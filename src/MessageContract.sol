// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MessageContract {
    string private message;
    uint256 private updateCount;

    constructor() {
        message = "Welcome to the blockchain!";
        updateCount = 0;
    }

    function getMessage() public view returns (string memory) {
        return message;
    }

    function getCount() public view returns (uint256) {
        return updateCount;
    }

    function updateMessage(string memory newMessage) public {
        message = newMessage;
        updateCount += 1;
    }
}
