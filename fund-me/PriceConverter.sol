// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
    // get price of ETH in USD by using Oracle 
    function getPrice() internal view returns(uint256){
        // Chainlink's Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // Chainlink's ABI:  AggregatorV3Interface -> github link: https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
         // price of ETH in USD (with 8 decimals)
         (,int256 price,,,) = priceFeed.latestRoundData();
         // Normalize price to 18 decimals (from 8 decimals)
         uint256 normalizedPrice = uint256(price * 1e10);
         
         return normalizedPrice;
    }

    // convert the msg.value by using the getPrice() method => we will have msg.value in USD
    function getConversionRate(uint256 ethAmount) internal view returns(uint256){
        uint256 ethToUsdPrice = getPrice();
        uint256 usdAmount = (ethAmount * ethToUsdPrice) / 1e18;
        return usdAmount;
    }

    // function getVersion() public view returns(uint256){
    //     // cast address to a interface
    //     AggregatorV3Interface  priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    //     return priceFeed.version();
    // }
}