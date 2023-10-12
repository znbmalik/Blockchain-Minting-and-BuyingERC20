// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

/* Contract Interaction: When a contract interacts with another contract through an 
interface, it only needs to know the function signatures and their expected behavior.
It doesn't need to know the underlying logic or complexity of the other contract.
Developers who want to interact with ERC-20 tokens in their own smart contracts 
or applications write an interface based on the functions and events defined by 
the ERC-20 standard. */

interface IERC20
{
    function transfer(address _reciever, uint _requireTokens) external returns(bool);
    function approveToken(address _spender,uint _amount)external returns(bool);
     function tranferFrom(address _from, address _to, uint _amount)external returns(bool);
    function mint(address _to,uint _amount ) external returns(bool);
    function burn(uint _amount) external;
    function getBalanceOf(address _account)external view returns(uint);
  
    function getAllowance(address _sender, address _spender)external view returns(uint);
    function totalSupply( )external view returns(uint);

    function name( )external view returns(string memory);
    function symbol( )external view returns(string memory);
    function deciaml( )external view returns(uint);
    function owner( )external view returns(address);
    function updateOwnerBalance(uint _etherBalance)external;
    event transferFrom(address _from,address _to, uint _transferedtoken);
    event transferEvent(address _from,address _to,uint _totalSupply,uint _transferedtoken);
    event approval(address owner,address spender,uint _amount);
    
}

