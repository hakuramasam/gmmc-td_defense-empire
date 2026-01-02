
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract SkinNFT is ERC1155, AccessControl, Pausable {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    enum Rarity {Common, Uncommon, Rare, Epic, Legendary}
    mapping(uint256 => Rarity) public skinRarity;

    constructor() ERC1155("https://api.empirebuilders.io/skins/{id}.json") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function mint(address to, uint256 id, uint256 amount, Rarity rarity)
        external whenNotPaused onlyRole(MINTER_ROLE)
    {
        _mint(to, id, amount, "");
        skinRarity[id] = rarity;
    }

    function burn(address from, uint256 id, uint256 amount)
        external whenNotPaused onlyRole(BURNER_ROLE)
    {
        _burn(from, id, amount);
    }

    function pause() external onlyRole(DEFAULT_ADMIN_ROLE) { _pause(); }
    function unpause() external onlyRole(DEFAULT_ADMIN_ROLE) { _unpause(); }
}
