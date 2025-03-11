// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {MessageContract} from "src/MessageContract.sol";

contract DeployMessageContract is Script {
    function run() external returns (MessageContract) {
        vm.startBroadcast();
        MessageContract messageContract = new MessageContract();
        vm.stopBroadcast();

        return messageContract;
    }
}
