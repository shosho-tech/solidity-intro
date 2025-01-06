// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory{
    SimpleStorage[] public simpleStorageContractList;

    function createSimpleStorageContract() public{
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageContractList.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint _newSimpleStorageNumber) public{
        // Contract's address
        // Contract's ABI = Application Binary Interface
        simpleStorageContractList[_simpleStorageIndex].store(_newSimpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        return simpleStorageContractList[_simpleStorageIndex].retrieve();
    }

}
