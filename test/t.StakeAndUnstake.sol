// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import { IERC20 } from "../src/Interfaces/IERC20.sol";
import "../lib/forge-std/src/Test.sol";
import "../src/StakeAndUnstake.sol";

contract StakeAndUnstakeTest is Test {
    uint256 public MAX_INT = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
    IERC20 public ghst = IERC20(0x385Eeac5cB85A38A9a07A70c73e0a3271CfB54A7);
    IERC20 public wapGhst = IERC20(0x73958d46B7aA2bc94926d8a215Fa560A5CdCA3eA);
    StakeAndUnstake public stakeAndUnstake = StakeAndUnstake(0xc2aA7D0Fd191153143F2f0E62867a0d64014216B);

    function test_StakeAndUnstake() public {
        vm.startPrank(address(1337));
        deal(0x385Eeac5cB85A38A9a07A70c73e0a3271CfB54A7, address(1337), 20 * 10e18);
        uint256 balance = ghst.balanceOf(address(1337));
        assertEq(balance, 20 * 10e18);
        ghst.approve(0xc2aA7D0Fd191153143F2f0E62867a0d64014216B, MAX_INT);
        stakeAndUnstake.stakingFunction(20 * 10e18);
        balance = ghst.balanceOf(address(1337));
        assertEq(balance, 0);
        stakeAndUnstake.unstakingFunction(20 * 10e18);
        balance = ghst.balanceOf(address(1337));
        assertEq(balance, 20 * 10e18 - 1);
        balance = wapGhst.balanceOf(0xc2aA7D0Fd191153143F2f0E62867a0d64014216B);
        assertEq(balance, 0);
    }
}
