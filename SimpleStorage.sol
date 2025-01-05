// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;  

contract SimpleStorage{
    uint256 internal s_favoriteNumber;

    struct Person{
        uint256 favoriteNumber;
        string name;
    }

    Person[] public friendsArray; // []
    mapping (string => uint256) public nameToFavoriteNumber;

    function store(uint _favoriteNumber) public {
        s_favoriteNumber = _favoriteNumber;
    }

    // view, pure 
    function retrieveFavoriteNumber() public view returns (uint256){
        return s_favoriteNumber;
    }

    // calldata, memory, storage
    function addPerson(string calldata _name, uint256 _favoriteNumber) public {
        // _name = "alaba";
        Person memory person = Person(_favoriteNumber, _name);
        friendsArray.push(person);
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

    


}
