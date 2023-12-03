// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

interface IWapGhst {

    function enter(uint256 assets) external;

    function leave(uint256 shares) external;

    function enterWithUnderlying(uint256 assets) external returns (uint256 shares);

    function leaveToUnderlying(uint256 shares) external returns (uint256 assets);
    
    function previewDeposit(uint256 assets) external view returns (uint256);
    
    function previewWithdraw(uint256 assets) external view returns (uint256);
}
