// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Mapping {
  // Simple mapping
  mapping(address => uint) public balances;

  // Nested mapping
  mapping(address => mapping(address => bool)) public allowed;

  function mappingOperations() external {
    // Assignment of a value to a key in the mapping
    balances[msg.sender] = 100;

    // Accessing a value from a key in the mapping
    uint balance = balances[msg.sender]; // 100

    // Accessing a value from a non-existent or unassigned key in the mapping
    uint nonexistent = balances[address(1)]; // 0

    // Delete a key from the mapping
    delete balances[msg.sender]; // 0

    // Accessing the value of a nested mapping
    bool isAllowed = allowed[msg.sender][msg.sender]; // false
  }
}
