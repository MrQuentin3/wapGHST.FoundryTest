// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import "../lib/forge-std/src/Test.sol";
import "../contracts/NewJob.sol";
import "../contracts/BidAndWithdraw.sol";
import "../contracts/Interfaces/IERC20.sol";

contract NewJobTest is Test {
    uint256 public MAX_INT = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
    IERC20 public ghst = IERC20(0x385Eeac5cB85A38A9a07A70c73e0a3271CfB54A7);
    IERC20 public wapGhst = IERC20(0x73958d46B7aA2bc94926d8a215Fa560A5CdCA3eA);
    NewJob public newJob = NewJob(0x5402aA9F736804901aa4996FDed53dCEccE6A5A5);
    BidAndWithdraw public withdraw = BidAndWithdraw(0x5402aA9F736804901aa4996FDed53dCEccE6A5A5);

    function test_ProposeNewJob() public {
        vm.startPrank(address(1));
        deal(0x385Eeac5cB85A38A9a07A70c73e0a3271CfB54A7, address(1), 20 * 10**18);
        uint256 balance = ghst.balanceOf(address(1));
        assertEq(balance, 20 * 10**18);
        ghst.approve(0x5402aA9F736804901aa4996FDed53dCEccE6A5A5, MAX_INT);
        newJob.proposeNewJob(0, 20 * 10**18, 0, 0x385Eeac5cB85A38A9a07A70c73e0a3271CfB54A7, address(0));
        balance = ghst.balanceOf(address(1));
        assertEq(balance, 0);
        withdraw.cancelJob(1);
        balance = ghst.balanceOf(address(1));
        assertEq(balance, 20 * 10**18 - 1);
        balance = wapGhst.balanceOf(0x5402aA9F736804901aa4996FDed53dCEccE6A5A5);
        assertEq(balance, 0);
    }
}
