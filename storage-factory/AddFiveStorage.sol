// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {SimpleStorage} from "./SimpleStorage.sol";

contract AddFiveContract is SimpleStorage{

     function store(uint256 _favoriteNumber) public override {
        myFavoriteNumber = _favoriteNumber + 5;
    }

    function sayHello() public pure returns (string memory){
        return "Hello";
    }


}