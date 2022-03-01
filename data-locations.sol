// SPDX-License-Identifier: MIT

/*
 ** Data Locations
 ** When dealing with dynamic data types, data locations are used to tell Solidity how to work with those types:
 ** - Memory means the variable is stored in memory. This is used only to read data from the blockchain
 ** - Storage means the variable is a state variable. This is used to read and write data to the blockchain
 ** - Calldata operates just like memory except it is for function parameters only. It has the potential to save gas
 **   when the function argument is passed to another function because solidity does not create a fresh copy of the argument.
 */

pragma solidity ^0.8.4;

contract DataLocations {
    address public owner;

    struct User {
        uint8 age;
        string name;
    }

    mapping(address => User) public users;

    modifier OnlyOwner {
        require(msg.sender == owner, "not owner");
        _;
    }

    constructor() {
        owner = msg.sender;
        users[owner] = User({age: 42, name: "Ryan Seacrest"});
    }

    // If the data location is set to memory, then changes to the state variable users are not persisted on the blockchain
    function setUserUsingMemory() public view OnlyOwner {
        User memory adam = users[owner];
        adam.name = "Ryan Reynolds";
    }

    // If the data location is set to storage, then changes to the mapping can be written to the blockchain
    function setUserUsingStorage() public OnlyOwner {
        User storage adam = users[owner];
        adam.name = "Ryan Gosling";
    }

    // When a data location is not specified and state data is modified, a default data location of storage is implied
    function setUserDefault() public OnlyOwner {
        users[owner].name = "Ryan Dorsey";
    }

    // Get the owner's name from the users state variable
    function getUser() public view OnlyOwner returns(string memory){
        return users[owner].name;
    }
}