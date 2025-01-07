// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {PriceConverter} from "./PriceConverter.sol";

// Fund a contract
// Withdraw a contract
// set a minimum funding value in USD

error NotOwner();

contract FundMe{
    using PriceConverter for uint256;

    address public immutable i_owner;
    uint256 public constant MINIMUM_USD = 5 * 1e18;

    address[] public funders;
    mapping (address => uint256) public addressToAmountFunded;

    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable {
        // allow users to send $
        // have a minimum $ sent
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Did not send enough ETH!"); 
        // 1e18 = 1 ETH = 1000000000000000000 = 1 * 10 * 18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw () public ownerOnly{
        // reset funders array
        // 1-st way:
        for (uint256 funderIndex=0; funderIndex < funders.length; funderIndex++) 
        {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // 2-nd way
        funders = new address[](0);

        // withdraw the funds
        // 3 ways to send ETH on Solidity: transfer, send, call
        
        // transfer
        // payable(msg.sender).transfer(address(this).balance);

        // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed.");

        // call - low level method
        (bool callSuccess,) = payable (msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed.");

    }

    modifier ownerOnly(){
        // require(msg.sender == i_owner, "Sender is not owner.");
        if(msg.sender != i_owner){
            revert NotOwner();
        }
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable{
        fund();
    }

}