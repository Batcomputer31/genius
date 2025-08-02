// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

/**
 * @title New Bitcoin (NBTC) - The Next Generation Digital Currency
 * @dev Enhanced Bitcoin with modern features: staking, deflation, smart contracts, and governance
 * @author Future Blockchain Labs
 */
contract NewBitcoin is ERC20, ERC20Burnable, ERC20Pausable, Ownable, ReentrancyGuard {
    using SafeMath for uint256;

    // Bitcoin-inspired Constants
    uint256 private constant MAX_SUPPLY = 21_000_000 * 10**18; // 21M like Bitcoin
    uint256 private constant INITIAL_SUPPLY = 1_000_000 * 10**18; // 1M initial
    uint256 private constant HALVING_INTERVAL = 210000; // Blocks between halvings
    uint256 private constant MINING_REWARD_INITIAL = 50 * 10**18; // 50 NBTC per block
    uint256 private constant STAKING_APY = 400; // 4% APY
    uint256 private constant DEFLATIONARY_RATE = 100; // 1% burn on transfers
    uint256 private constant SECONDS_PER_YEAR = 365 * 24 * 60 * 60;

    // Enhanced Features
    struct MinerData {
        uint256 totalMined;
        uint256 lastMineTime;
        uint256 miningPower;
        bool isActiveMiner;
    }

    struct StakingData {
        uint256 stakedAmount;
        uint256 stakeTime;
        uint256 lastRewardTime;
        uint256 accumulatedRewards;
        uint256 lockPeriod; // Days locked
    }

    struct GovernanceProposal {
        string description;
        uint256 votesFor;
        uint256 votesAgainst;
        uint256 endTime;
        bool executed;
        address proposer;
    }

    // State Variables
    mapping(address => MinerData) public miners;
    mapping(address => StakingData) public stakers;
    mapping(address => bool) public authorizedMiners;
    mapping(uint256 => GovernanceProposal) public proposals;
    mapping(address => mapping(uint256 => bool)) public hasVoted;

    uint256 public currentBlockReward;
    uint256 public totalMined;
    uint256 public totalStaked;
    uint256 public totalBurned;
    uint256 public halvingCount;
    uint256 public proposalCount;
    uint256 public minimumStakeForVoting;

    bool public miningActive = true;
    bool public stakingActive = true;
    bool public deflationActive = true;
    bool public governanceActive = true;

    // Events
    event Mined(address indexed miner, uint256 amount, uint256 blockNumber);
    event Staked(address indexed staker, uint256 amount, uint256 lockPeriod);
    event Unstaked(address indexed staker, uint256 amount, uint256 rewards);
    event Burned(uint256 amount, string reason);
    event Halving(uint256 newReward, uint256 halvingNumber);
    event ProposalCreated(uint256 indexed proposalId, address indexed proposer, string description);
    event Voted(uint256 indexed proposalId, address indexed voter, bool support, uint256 power);
    event ProposalExecuted(uint256 indexed proposalId);

    // Custom Errors
    error MaxSupplyExceeded();
    error InsufficientMiningPower();
    error NotAuthorizedMiner();
    error InsufficientStake();
    error StillLocked();
    error AlreadyVoted();
    error ProposalEnded();
    error InsufficientVotingPower();

    constructor() ERC20("New Bitcoin", "NBTC") {
        currentBlockReward = MINING_REWARD_INITIAL;
        minimumStakeForVoting = 1000 * 10**18; // 1000 NBTC to vote
        _mint(msg.sender, INITIAL_SUPPLY);
        authorizedMiners[msg.sender] = true;
    }

    /**
     * @dev Enhanced transfer with deflationary mechanism
     */
    function transfer(address to, uint256 amount) 
        public 
        override 
        whenNotPaused 
        returns (bool) 
    {
        address owner = _msgSender();
        
        if (deflationActive && to != address(this)) {
            uint256 burnAmount = amount.mul(DEFLATIONARY_RATE).div(10000);
            uint256 transferAmount = amount.sub(burnAmount);
            
            _burn(owner, burnAmount);
            totalBurned = totalBurned.add(burnAmount);
            emit Burned(burnAmount, "Transfer deflation");
            
            _transfer(owner, to, transferAmount);
            return true;
        }
        
        _transfer(owner, to, amount);
        return true;
    }

    /**
     * @dev Mine new NBTC tokens (Proof of Authority for simplicity)
     */
    function mine() external nonReentrant {
        if (!miningActive) revert("Mining not active");
        if (!authorizedMiners[msg.sender]) revert NotAuthorizedMiner();
        
        MinerData storage miner = miners[msg.sender];
        
        // Rate limiting: 1 mine per 10 minutes
        require(block.timestamp >= miner.lastMineTime + 600, "Too soon to mine");
        
        // Check if halving needed
        if (totalMined > 0 && totalMined.div(10**18) % HALVING_INTERVAL == 0 && currentBlockReward > 0) {
            _performHalving();
        }
        
        uint256 reward = currentBlockReward;
        if (totalSupply().add(reward) > MAX_SUPPLY) {
            reward = MAX_SUPPLY.sub(totalSupply());
        }
        
        if (reward > 0) {
            _mint(msg.sender, reward);
            miner.totalMined = miner.totalMined.add(reward);
            miner.lastMineTime = block.timestamp;
            totalMined = totalMined.add(reward);
            
            emit Mined(msg.sender, reward, block.number);
        }
    }

    /**
     * @dev Stake NBTC for rewards
     */
    function stake(uint256 amount, uint256 lockDays) external nonReentrant whenNotPaused {
        require(stakingActive, "Staking not active");
        require(amount > 0, "Cannot stake 0");
        require(lockDays >= 30 && lockDays <= 365, "Lock period must be 30-365 days");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");

        _updateStakingRewards(msg.sender);

        StakingData storage staker = stakers[msg.sender];
        staker.stakedAmount = staker.stakedAmount.add(amount);
        staker.stakeTime = block.timestamp;
        staker.lockPeriod = lockDays;
        staker.lastRewardTime = block.timestamp;

        totalStaked = totalStaked.add(amount);
        _transfer(msg.sender, address(this), amount);

        emit Staked(msg.sender, amount, lockDays);
    }

    /**
     * @dev Unstake NBTC and claim rewards
     */
    function unstake(uint256 amount) external nonReentrant {
        StakingData storage staker = stakers[msg.sender];
        require(staker.stakedAmount >= amount, "Insufficient staked amount");
        
        uint256 lockEndTime = staker.stakeTime.add(staker.lockPeriod.mul(1 days));
        require(block.timestamp >= lockEndTime, "Still locked");

        _updateStakingRewards(msg.sender);

        uint256 rewards = staker.accumulatedRewards;
        staker.stakedAmount = staker.stakedAmount.sub(amount);
        staker.accumulatedRewards = 0;
        totalStaked = totalStaked.sub(amount);

        // Mint rewards
        if (rewards > 0 && totalSupply().add(rewards) <= MAX_SUPPLY) {
            _mint(msg.sender, rewards);
        }

        _transfer(address(this), msg.sender, amount);
        emit Unstaked(msg.sender, amount, rewards);
    }

    /**
     * @dev Create governance proposal
     */
    function createProposal(string memory description) external {
        require(governanceActive, "Governance not active");
        require(stakers[msg.sender].stakedAmount >= minimumStakeForVoting, "Insufficient voting power");

        proposals[proposalCount] = GovernanceProposal({
            description: description,
            votesFor: 0,
            votesAgainst: 0,
            endTime: block.timestamp.add(7 days),
            executed: false,
            proposer: msg.sender
        });

        emit ProposalCreated(proposalCount, msg.sender, description);
        proposalCount++;
    }

    /**
     * @dev Vote on governance proposal
     */
    function vote(uint256 proposalId, bool support) external {
        require(proposalId < proposalCount, "Invalid proposal");
        require(!hasVoted[msg.sender][proposalId], "Already voted");
        require(block.timestamp < proposals[proposalId].endTime, "Proposal ended");

        uint256 votingPower = stakers[msg.sender].stakedAmount;
        require(votingPower >= minimumStakeForVoting, "Insufficient voting power");

        hasVoted[msg.sender][proposalId] = true;

        if (support) {
            proposals[proposalId].votesFor = proposals[proposalId].votesFor.add(votingPower);
        } else {
            proposals[proposalId].votesAgainst = proposals[proposalId].votesAgainst.add(votingPower);
        }

        emit Voted(proposalId, msg.sender, support, votingPower);
    }

    /**
     * @dev Get staking rewards for an address
     */
    function getStakingRewards(address staker) external view returns (uint256) {
        StakingData memory data = stakers[staker];
        if (data.stakedAmount == 0) return data.accumulatedRewards;

        uint256 timeStaked = block.timestamp.sub(data.lastRewardTime);
        uint256 lockBonus = data.lockPeriod.mul(10); // Bonus for longer locks
        uint256 adjustedAPY = STAKING_APY.add(lockBonus);
        
        uint256 newRewards = data.stakedAmount
            .mul(adjustedAPY)
            .mul(timeStaked)
            .div(10000)
            .div(SECONDS_PER_YEAR);

        return data.accumulatedRewards.add(newRewards);
    }

    /**
     * @dev Get mining statistics
     */
    function getMiningStats() external view returns (
        uint256 currentReward,
        uint256 nextHalving,
        uint256 totalMinedTokens,
        uint256 remainingSupply
    ) {
        return (
            currentBlockReward,
            HALVING_INTERVAL.sub(totalMined.div(10**18) % HALVING_INTERVAL),
            totalMined,
            MAX_SUPPLY.sub(totalSupply())
        );
    }

    /**
     * @dev Internal function to perform halving
     */
    function _performHalving() internal {
        currentBlockReward = currentBlockReward.div(2);
        halvingCount++;
        emit Halving(currentBlockReward, halvingCount);
    }

    /**
     * @dev Update staking rewards for a user
     */
    function _updateStakingRewards(address user) internal {
        StakingData storage staker = stakers[user];
        if (staker.stakedAmount == 0) {
            staker.lastRewardTime = block.timestamp;
            return;
        }

        uint256 timeStaked = block.timestamp.sub(staker.lastRewardTime);
        uint256 lockBonus = staker.lockPeriod.mul(10);
        uint256 adjustedAPY = STAKING_APY.add(lockBonus);
        
        uint256 newRewards = staker.stakedAmount
            .mul(adjustedAPY)
            .mul(timeStaked)
            .div(10000)
            .div(SECONDS_PER_YEAR);

        staker.accumulatedRewards = staker.accumulatedRewards.add(newRewards);
        staker.lastRewardTime = block.timestamp;
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
    function addMiner(address miner) external onlyOwner {
        authorizedMiners[miner] = true;
    }

    function removeMiner(address miner) external onlyOwner {
        authorizedMiners[miner] = false;
    }

    function toggleMining() external onlyOwner {
        miningActive = !miningActive;
    }

    function toggleStaking() external onlyOwner {
        stakingActive = !stakingActive;
    }

    function toggleDeflation() external onlyOwner {
        deflationActive = !deflationActive;
    }

    function emergencyBurn(uint256 amount) external onlyOwner {
        require(amount <= balanceOf(address(this)), "Insufficient contract balance");
        _burn(address(this), amount);
        totalBurned = totalBurned.add(amount);
        emit Burned(amount, "Emergency burn");
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }
}