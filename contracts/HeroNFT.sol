
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract HeroNFT is ERC721Enumerable, AccessControl, Pausable {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    enum Rarity {Common, Uncommon, Rare, Epic, Legendary}
    mapping(uint256 => Rarity) public heroRarity;
    uint256 public tokenIdCounter;

    constructor() ERC721("EmpireBuilders Hero", "EBH") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function mint(address to, Rarity rarity) external whenNotPaused onlyRole(MINTER_ROLE) {
        tokenIdCounter++;
        _safeMint(to, tokenIdCounter);
        heroRarity[tokenIdCounter] = rarity;
    }

    function pause() external onlyRole(DEFAULT_ADMIN_ROLE) { _pause(); }
    function unpause() external onlyRole(DEFAULT_ADMIN_ROLE) { _unpause(); }
}
