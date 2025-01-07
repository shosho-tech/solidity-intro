// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract FallbackExample{

    uint256 public result;

    receive() external payable{
        result = 3;
    }

    fallback() external payable{
        result = 5;
    }

}