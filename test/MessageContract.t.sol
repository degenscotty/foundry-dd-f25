// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MessageContract.sol"; // Adjust path based on your project structure

contract MessageContractTest is Test {
    MessageContract messageContract;

    // Initial values from constructor
    string constant INITIAL_MESSAGE = "Welcome to the blockchain!";
    uint256 constant INITIAL_COUNT = 0;

    // Test events (even though contract has none, showing best practice)
    event MessageUpdated(string newMessage);

    function setUp() public {
        messageContract = new MessageContract();
    }

    // Test constructor initialization
    function test_InitialState() public view {
        assertEq(
            messageContract.getMessage(),
            INITIAL_MESSAGE,
            "Initial message should match constructor"
        );
        assertEq(messageContract.getCount(), INITIAL_COUNT, "Initial count should be 0");
    }

    // Test getMessage function
    function test_GetMessage() public {
        string memory currentMessage = messageContract.getMessage();
        assertEq(currentMessage, INITIAL_MESSAGE, "getMessage should return initial message");

        // Update message and verify
        string memory newMessage = "Hello, World!";
        messageContract.updateMessage(newMessage);
        assertEq(
            messageContract.getMessage(),
            newMessage,
            "getMessage should return updated message"
        );
    }

    // Test getCount function
    function test_GetCount() public {
        assertEq(messageContract.getCount(), INITIAL_COUNT, "Initial count should be 0");

        // Update message once
        messageContract.updateMessage("Test 1");
        assertEq(messageContract.getCount(), 1, "Count should be 1 after one update");

        // Update message again
        messageContract.updateMessage("Test 2");
        assertEq(messageContract.getCount(), 2, "Count should be 2 after two updates");
    }

    // Test updateMessage function
    function test_UpdateMessage() public {
        string memory newMessage = "New message test";

        // Store old count
        uint256 oldCount = messageContract.getCount();

        // Update message
        messageContract.updateMessage(newMessage);

        // Verify new message
        assertEq(messageContract.getMessage(), newMessage, "Message should be updated");

        // Verify count increment
        assertEq(messageContract.getCount(), oldCount + 1, "Count should increment by 1");
    }

    // Test multiple updates
    function test_MultipleUpdates() public {
        string[3] memory messages = ["First update", "Second update", "Third update"];

        for (uint i = 0; i < messages.length; i++) {
            messageContract.updateMessage(messages[i]);
            assertEq(
                messageContract.getMessage(),
                messages[i],
                "Message should match latest update"
            );
            assertEq(messageContract.getCount(), i + 1, "Count should match number of updates");
        }
    }

    // Test with empty string
    function test_UpdateWithEmptyString() public {
        messageContract.updateMessage("");
        assertEq(messageContract.getMessage(), "", "Message should be empty string");
        assertEq(messageContract.getCount(), 1, "Count should increment with empty string update");
    }

    // Fuzz test with random string input
    function testFuzz_UpdateMessage(string memory randomMessage) public {
        uint256 oldCount = messageContract.getCount();
        messageContract.updateMessage(randomMessage);

        assertEq(messageContract.getMessage(), randomMessage, "Message should match input");
        assertEq(messageContract.getCount(), oldCount + 1, "Count should increment");
    }
}
