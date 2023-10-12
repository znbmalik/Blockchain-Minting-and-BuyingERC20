// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
import "./InterfaceERC20.sol";


contract BuyERC20Token {
    IERC20 public token;
    uint public price_per_token;
    uint public total_token_sold = 0;
    address[] private contributors;
    mapping(address => bool) public contributeMap;

    event tokenPurchased(
        address _to,
        uint _price_per_token,
        uint _total_token_sold,
        uint _pricePaid
    );

    constructor(address _token, uint _price_per_token) {
        token = IERC20(_token);
        price_per_token = _price_per_token;
    }

    function buyToken(uint _amount) public payable {
        //require(contributeMap[msg.sender] == false,"Already a contributor");
        require(_amount > 0, "Invalid No. of Requested Tokens");
        uint remainingToken = token.totalSupply() - total_token_sold;
        require(remainingToken > _amount, "Insufficent tokens");
        uint pricePayable = price_per_token * _amount;
        require(msg.value == pricePayable, "Insuffcient amount");
        token.transfer(msg.sender, _amount);

        // Next 2 lines optional, we will use these two if we want to get ether directly in owners account
        address payable owner = payable(token.owner());
        owner.transfer(msg.value);


        total_token_sold += _amount;
        if (contributeMap[msg.sender] == false) {
            contributeMap[msg.sender] = true;
            contributors.push(msg.sender);
        }
        emit tokenPurchased(msg.sender, price_per_token, _amount, pricePayable);
    }

    function withdraw() public returns (bool) {
        address payable owner = payable(token.owner());
        owner.transfer(address(this).balance);
        return true;
    }

    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }

    function getContributors() public view returns (address[] memory) {
        return contributors;
    }
}
