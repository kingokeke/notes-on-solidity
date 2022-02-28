// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Array {
    uint256[] public dynamicArr = [1, 2, 3]; // dynamic size array
    uint256[3] public fixedArr = [4, 5, 6]; // fixed size array

    // Array in memory can only be declared from within a function
    function initArrayInMemory() internal pure {
        uint256[] memory memoryArray = new uint256[](3); // array in memory
    }

    // Operations that can be performed on all arrays
    function arrayOperations() internal {
        // Get value of array element at given index
        uint256 item = fixedArr[1]; // 5

        // Set value of array element at given index
        dynamicArr[2] = 10; // [1, 2, 10]

        // Return the length of the array
        uint256 arrLength = dynamicArr.length; // 3

        // Delete an item from the array. Observe that the length of the array DOES NOT change
        delete fixedArr[1]; // [4, 0, 6]
    }

    // Operations that can be performed only on dynamic size arrays
    function dynamicArrOps() internal {
        // Add new element to the array
        dynamicArr.push(4); // [1, 2, 3, 4]

        // Remove an element from the end of the array
        dynamicArr.pop(); // [1, 2, 3]
    }

    // Function to remove an element at index.
    // This method is O(n) time complexity and uses up a lot of gas but preserves order of elements
    // For example, removeElemAtIndex(1) -> [1, 2, 3, 4] -> [1, 3, 4, 4] -> [1, 3, 4]
    function removeElemAtIndex(uint256 _index) public {
        uint256 arrLength = dynamicArr.length;

        require(_index < arrLength, "index out of bounds");

        for (uint256 i = _index; i < arrLength - 1; i++) {
            dynamicArr[i] = dynamicArr[i + 1];
        }

        dynamicArr.pop();
    }

    // Function to remove an element at index.
    // This method is O(1) time complexity and uses much less gas but shuffles the order of elements
    // For example, removeElementAtIndex(1) -> [1, 2, 3, 4] -> [1, 4, 3, 4] -> [1, 4, 3]
    function removeElementAtIndex(uint256 _index) public {
        dynamicArr[_index] = dynamicArr[dynamicArr.length - 1];
        dynamicArr.pop();
    }

    // Return an array from the smart contract
    function returnArr() external view returns (uint256[3] memory) {
        return fixedArr;
    }
}

// NOTE:
// It is not advised to return arrays from functions due to gas concerns.
// In the same vein, I think it is not advisable to make dynamic arrays public.
// I will need to confirm this.
