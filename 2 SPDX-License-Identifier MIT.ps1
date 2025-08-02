// SPDX-License-Identifier: MITpragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/**
 * @title EvoCoin (EQ) - Enhanced Evolution Token
 * @dev Advanced ERC20 token with evolution mechanics, staking, and governance features
 * @author AI Evolution Labs
 */
contract EvoToken is ERC20, ERC20Burnable, ERC20Pausable, Ownable, ReentrancyGuard {

    // Evolution System Constants
    uint256 private constant EVOLUTION_THRESHOLD = 10000 * 10**18; // 10,000 EQ
    uint256 private constant STAKING_REWARD_RATE = 500; // 5% APY (500 basis points)
    uint256 private constant EVOLUTION_BONUS_MULTIPLIER = 150; // 1.5x multiplier
    uint256 private constant SECONDS_PER_YEAR = 365 * 24 * 60 * 60;

    // Evolution Tracking
    struct EvolutionData {
        uint256 evolutionLevel;
        uint256 totalEvolved;
        uint256 lastEvolutionTime;
        bool isEvolutionActive;
    }

    // Staking System
    struct StakeInfo {
        uint256 stakedAmount;
        uint256 stakeTimestamp;
        uint256 lastRewardTime;
        uint256 accumulatedRewards;
        uint256 evolutionBonus;
    }

    // State Variables
    mapping(address => EvolutionData) public evolutionData;
    mapping(address => StakeInfo) public stakingInfo;
    mapping(address => bool) public isEvolutionEligible;

    uint256 public totalStaked;
    uint256 public totalEvolutionRewards;
    uint256 public maxSupply;
    bool public evolutionSystemActive = true;

    // Events
    event Evolution(address indexed user, uint256 level, uint256 bonus);
    event Staked(address indexed user, uint256 amount);
    event Unstaked(address indexed user, uint256 amount, uint256 rewards);
    event RewardsClaimed(address indexed user, uint256 rewards);
    event EvolutionSystemToggled(bool active);

    // Custom Errors
    error InsufficientBalance();
    error InsufficientStake();
    error EvolutionNotReady();
    error EvolutionSystemInactive();
    error MaxSupplyExceeded();
    error ZeroAmount();

    constructor() ERC20("EvoCoin", "EQ") {
        maxSupply = 100_000_000 * 10**decimals(); // 100M max supply
        _mint(msg.sender, 1_000_000 * 10**decimals()); // Initial 1M supply
    }

    /**
     * @dev Enhanced transfer with evolution tracking
     */
    function transfer(address to, uint256 amount)
        public
        override
        whenNotPaused
        returns (bool)
    {
        address owner = _msgSender();
        _trackEvolution(owner, amount);
        _transfer(owner, to, amount);
        return true;
    }

    /**
     * @dev Enhanced transferFrom with evolution tracking
     */
    function transferFrom(address from, address to, uint256 amount)
        public
        override
        whenNotPaused
        returns (bool)
    {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _trackEvolution(from, amount);
        _transfer(from, to, amount);
        return true;
    }

    /**
     * @dev Stake tokens to earn rewards and evolution points
     */
    function stake(uint256 amount) external nonReentrant whenNotPaused {
        if (amount == 0) revert ZeroAmount();
        if (balanceOf(msg.sender) < amount) revert InsufficientBalance();

        _updateRewards(msg.sender);

        stakingInfo[msg.sender].stakedAmount += amount;
        stakingInfo[msg.sender].stakeTimestamp = block.timestamp;
        totalStaked += amount;

        _transfer(msg.sender, address(this), amount);

        // Check evolution eligibility
        if (stakingInfo[msg.sender].stakedAmount >= EVOLUTION_THRESHOLD) {
            isEvolutionEligible[msg.sender] = true;
        }

        emit Staked(msg.sender, amount);
    }

    /**
     * @dev Unstake tokens and claim rewards
     */
    function unstake(uint256 amount) external nonReentrant {
        if (amount == 0) revert ZeroAmount();
        if (stakingInfo[msg.sender].stakedAmount < amount) revert InsufficientStake();

        _updateRewards(msg.sender);

        uint256 rewards = stakingInfo[msg.sender].accumulatedRewards;
        stakingInfo[msg.sender].stakedAmount -= amount;
        stakingInfo[msg.sender].accumulatedRewards = 0;
        totalStaked -= amount;

        // Mint rewards if any
        if (rewards > 0) {
            _mintRewards(msg.sender, rewards);
        }

        _transfer(address(this), msg.sender, amount);

        emit Unstaked(msg.sender, amount, rewards);
    }

    /**
     * @dev Claim accumulated staking rewards
     */
    function claimRewards() external nonReentrant {
        _updateRewards(msg.sender);

        uint256 rewards = stakingInfo[msg.sender].accumulatedRewards;
        if (rewards == 0) revert ZeroAmount();

        stakingInfo[msg.sender].accumulatedRewards = 0;
        _mintRewards(msg.sender, rewards);

        emit RewardsClaimed(msg.sender, rewards);
    }

    /**
     * @dev Trigger evolution for eligible addresses
     */
    function evolve() external {
        if (!evolutionSystemActive) revert EvolutionSystemInactive();
        if (!isEvolutionEligible[msg.sender]) revert EvolutionNotReady();

        EvolutionData storage data = evolutionData[msg.sender];

        // Require minimum time between evolutions (7 days)
        if (block.timestamp < data.lastEvolutionTime + 7 days) revert EvolutionNotReady();

        data.evolutionLevel++;
        data.lastEvolutionTime = block.timestamp;
        data.isEvolutionActive = true;

        // Calculate evolution bonus
        uint256 bonus = (stakingInfo[msg.sender].stakedAmount * EVOLUTION_BONUS_MULTIPLIER) / 1000;
        data.totalEvolved += bonus;
        stakingInfo[msg.sender].evolutionBonus += bonus;

        _mintRewards(msg.sender, bonus);

        emit Evolution(msg.sender, data.evolutionLevel, bonus);
    }

    /**
     * @dev Get pending rewards for an address
     */
    function getPendingRewards(address user) external view returns (uint256) {
        StakeInfo memory info = stakingInfo[user];
        if (info.stakedAmount == 0) return info.accumulatedRewards;

        uint256 timeStaked = block.timestamp - info.lastRewardTime;
        uint256 newRewards = (info.stakedAmount * STAKING_REWARD_RATE * timeStaked) /
                            (10000 * SECONDS_PER_YEAR);

        return info.accumulatedRewards + newRewards;
    }

    /**
     * @dev Get evolution status for an address
     */
    function getEvolutionStatus(address user) external view returns (
        uint256 level,
        uint256 totalEvolved,
        bool eligible,
        uint256 nextEvolutionTime
    ) {
        EvolutionData memory data = evolutionData[user];
        return (
            data.evolutionLevel,
            data.totalEvolved,
            isEvolutionEligible[user],
            data.lastEvolutionTime + 7 days
        );
    }

    /**
     * @dev Internal function to track evolution progress
     */
    function _trackEvolution(address user, uint256 amount) internal {
        if (!evolutionSystemActive) return;

        EvolutionData storage data = evolutionData[user];
        data.totalEvolved += amount / 1000; // Track micro-evolutions

        // Auto-enable evolution eligibility for large holders
        if (balanceOf(user) >= EVOLUTION_THRESHOLD) {
            isEvolutionEligible[user] = true;
        }
    }

    /**
     * @dev Update rewards for a user
     */
    function _updateRewards(address user) internal {
        StakeInfo storage info = stakingInfo[user];
        if (info.stakedAmount == 0) {
            info.lastRewardTime = block.timestamp;
            return;
        }

        uint256 timeStaked = block.timestamp - info.lastRewardTime;
        uint256 newRewards = (info.stakedAmount * STAKING_REWARD_RATE * timeStaked) /
                            (10000 * SECONDS_PER_YEAR);

        info.accumulatedRewards += newRewards;
        info.lastRewardTime = block.timestamp;
    }

    /**
     * @dev Mint rewards while respecting max supply
     */
    function _mintRewards(address to, uint256 amount) internal {
        if (totalSupply() + amount > maxSupply) revert MaxSupplyExceeded();

        _mint(to, amount);
        totalEvolutionRewards += amount;
    }

    /**
     * @dev Required override for Pausable
     */
    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        override(ERC20, ERC20Pausable)
    {
        super._beforeTokenTransfer(from, to, amount);
    }

    // Owner Functions
    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    function toggleEvolutionSystem() external onlyOwner {
        evolutionSystemActive = !evolutionSystemActive;
        emit EvolutionSystemToggled(evolutionSystemActive);
    }

    function setEvolutionEligible(address user, bool eligible) external onlyOwner {
        isEvolutionEligible[user] = eligible;
    }

    /**
     * @dev Emergency function to recover stuck tokens
     */
    function emergencyRecover(address token, uint256 amount) external onlyOwner {
        if (token == address(this)) {
            // Only allow recovery of non-staked tokens
            require(amount <= balanceOf(address(this)) - totalStaked, "Cannot recover staked tokens");
        }
        IERC20(token).transfer(owner(), amount);
    }
}


Sent with Proton Mail secure email.