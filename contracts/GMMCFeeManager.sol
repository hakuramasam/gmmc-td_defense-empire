
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library GMMCFeeManager {
    uint256 constant DENOM = 1e18;

    function usdToGMMC(uint256 usd, uint256 gmmcPerUsd) internal pure returns (uint256) {
        return usd * gmmcPerUsd;
    }
}
