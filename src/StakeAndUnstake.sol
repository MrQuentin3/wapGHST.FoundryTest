// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import { IERC20 } from "./Interfaces/IERC20.sol";
import { IWapGhst } from "./Interfaces/IWapGhst.sol";
import { IFarmFacet } from "./Interfaces/IFarmFacet.sol";
import { LibERC20 } from "./Libraries/LibERC20.sol";
 
contract StakeAndUnstake {

    uint256 internal constant MAX_INT = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
    address internal constant farmFacetContract = 0x1fE64677Ab1397e20A1211AFae2758570fEa1B8c;
    address internal constant ghstContract = 0x385Eeac5cB85A38A9a07A70c73e0a3271CfB54A7;
    address internal constant wapGhstContract = 0x73958d46B7aA2bc94926d8a215Fa560A5CdCA3eA;
    address internal constant aavePoolContract = 0x794a61358D6845594F94dc1DB02A252b5b4814aD;
    IWapGhst internal constant wapGhst = IWapGhst(wapGhstContract);
    IFarmFacet internal constant farmFacet = IFarmFacet(farmFacetContract);

    constructor() {
        IERC20(ghstContract).approve(wapGhstContract, MAX_INT);
        IERC20(wapGhstContract).approve(farmFacetContract, MAX_INT);  
    }

    function stakingFunction(
        uint256 _amount
    ) public {
        LibERC20.transferFrom(ghstContract, msg.sender, address(this), _amount);
        uint256 shares = wapGhst.enterWithUnderlying(_amount);
        farmFacet.deposit(0, shares);
    } 

    function unstakingFunction(
        uint256 _amount
    ) public {
        uint256 shares = wapGhst.previewWithdraw(_amount) - 1;
        farmFacet.withdraw(0, shares);
        wapGhst.leaveToUnderlying(shares);
        LibERC20.transfer(ghstContract, msg.sender, _amount - 1);
    } 

}

