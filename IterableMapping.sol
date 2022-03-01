// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract IterableMapping {
    // Mapping to track balances mapped to addresses
    mapping(address => uint256) public balances;

    // Mapping to track whether an address exists in the balances mapping
    mapping(address => bool) public inserted;

    // Array of all addresses in the balances array
    address[] public keys;

    // Set or update balance value of an address
    function setBalance(address _key, uint256 value) public {
        balances[_key] = value;

        if (!inserted[_key]) {
            inserted[_key] = true;
            keys.push(_key);
        }
    }

    // Get number of addresses in mapping
    function getSize() external view returns (uint256 size) {
        size = keys.length;
    }

    // Get balance of the first address added to the mapping
    function getFirstBalance() external view returns (uint256 bal) {
      bal = balances[keys[0]];
    }

    // Get balance of the last address added to the mapping
    function getLastBalance() external view returns (uint256 bal) {
      bal = balances[keys[keys.length - 1]];
    }

    // Get address at a particular index
    function getAddressAtIndex(uint256 _index) external view returns (address key) {
        key = keys[_index];
    }

    // Get balance of an address at a particular index
    function getBalanceAtIndex(uint256 _index) external view returns (uint256 bal) {
      bal = balances[keys[_index]];
    }
}
