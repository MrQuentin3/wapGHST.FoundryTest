// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "../lib/forge-std/src/Script.sol";
import { StakeAndUnstake } from 'src/StakeAndUnstake.sol';

contract ContractScript is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();
        new StakeAndUnstake();
    }
}

