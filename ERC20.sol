// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;
//import "hardhat/console.sol";
contract ERC20 {
    string public name = "My_Token";
    string public symbol = "FT_ERC";
    uint8 public decimals = 5;
    uint256 public totalSupply;
    address public owner;

    mapping(address => uint256) public balanceOf;
   
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(uint256 initialSupply) {
        totalSupply = initialSupply * 10 ** uint256(decimals);
        owner=msg.sender;
        balanceOf[owner] = totalSupply;
    }

    modifier onlyOwner()
    {
        require(msg.sender==owner,"Not allowed");
        _;
    }
    function transfer(address to, uint256 value) external returns (bool) {
        require(to != address(0), "Invalid address");
        //console.log("msg.send is:",msg.sender);
        require(balanceOf[owner] >= value, "Insufficient balance");
        balanceOf[owner] -= value;
        //balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) external returns (bool) {
        allowance[msg.sender][spender] = value;

        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        require(from != address(0), "Invalid address");
        require(to != address(0), "Invalid address");
        require(balanceOf[from] >= value, string.concat( "Insufficient balance at"));
        
        require(allowance[from][msg.sender] >= value, "Not enough Allowance");

        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowance[from][msg.sender] -= value;

        emit Transfer(from, to, value);
        return true;
    }
    function getAllowance(address from, address spender) public view returns(uint) {
        return allowance[from][spender];
    }

    function getBalanceOf(address _account)public view returns(uint)
    {
        return balanceOf[_account];
    }

    function getMsgSender()public view returns(address)
    {
        return msg.sender;
    }

     function getOwnerBalance()public view returns(uint)
   {
        return owner.balance;
   }

  
  

}