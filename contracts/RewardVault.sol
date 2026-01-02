
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
}

contract RewardVault is ReentrancyGuard, AccessControl {
    bytes32 public constant DISTRIBUTOR_ROLE = keccak256("DISTRIBUTOR_ROLE");
    IERC20 public gmmc;

    constructor(address gmmcToken) {
        gmmc = IERC20(gmmcToken);
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function distribute(address to, uint256 amount)
        external nonReentrant onlyRole(DISTRIBUTOR_ROLE)
    {
        gmmc.transfer(to, amount);
    }
}
