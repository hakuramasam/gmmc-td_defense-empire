
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

interface ISkinNFT {
    function burn(address from, uint256 id, uint256 amount) external;
    function mint(address to, uint256 id, uint256 amount, uint8 rarity) external;
}

contract FusionEngine is ReentrancyGuard, AccessControl {
    bytes32 public constant OPERATOR_ROLE = keccak256("OPERATOR_ROLE");
    ISkinNFT public skin;

    constructor(address skinAddress) {
        skin = ISkinNFT(skinAddress);
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function fuse(address user, uint256 id, uint8 rarity)
        external nonReentrant onlyRole(OPERATOR_ROLE)
    {
        skin.burn(user, id, 2);
        skin.mint(user, id + 1, 1, rarity + 1);
    }
}
