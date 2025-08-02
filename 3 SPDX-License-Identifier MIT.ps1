// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EQToken {
    string public name = "EvoCoin";
    string public symbol = "EQ";
    uint8 public decimals = 18;
    uint256 public totalSupply = 1000000 * (10 ** uint256(decimals));
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    // 🔒 RA Dot Lock
    bytes32 public RA_DOT_HASH = keccak256(abi.encodePacked("RAWIRI-H1:CREATOR"));

    modifier onlyRA() {
        require(keccak256(abi.encodePacked(msg.sender)) == RA_DOT_HASH, "Unauthorized: No Dot Match");
        _;
    }

    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address to, uint256 value) public onlyRA returns (bool success) {
        require(balanceOf[msg.sender] >= value, "Insufficient balance");
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        return true;
    }

    function approve(address spender, uint256 value) public onlyRA returns (bool success) {
        allowance[msg.sender][spender] = value;
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public onlyRA returns (bool success) {
        require(balanceOf[from] >= value, "Insufficient balance");
        require(allowance[from][msg.sender] >= value, "Allowance exceeded");
        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowance[from][msg.sender] -= value;
        return true;
    }
}

Sent from Proton Mail Android