// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable, Pausable, ReentrancyGuard {
    event ItemRedeemed(address indexed user, uint256 itemId, uint256 cost);

    struct StoreItem {
        uint256 itemId;
        string itemName;
        uint256 cost;
    }

    StoreItem[] public storeItems;

    constructor() ERC20("Haze", "HZE") {
        _initializeStoreItems();
    }

    function mint(address to, uint256 amount) external onlyOwner whenNotPaused {
        _mint(to, amount);
    }

    function decimals() public pure override returns (uint8) {
        return 0;
    }

    function transferTokens(address receiver, uint256 value) external whenNotPaused nonReentrant {
        _transfer(msg.sender, receiver, value);
    }

    function burnTokens(uint256 value) external whenNotPaused nonReentrant {
        _burn(msg.sender, value);
    }

    function redeemTokens(uint256 itemId) external whenNotPaused nonReentrant {
        uint256 cost = _getItemCost(itemId);
        require(balanceOf(msg.sender) >= cost, "Insufficient tokens.");
        _burn(msg.sender, cost);
        emit ItemRedeemed(msg.sender, itemId, cost);
    }

    function getBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function getBalanceOf(address account) external view returns (uint256) {
        return balanceOf(account);
    }

    function showStoreItems() external view returns (string memory) {
        string memory items = "Available Store Items:\n";
        for (uint i = 0; i < storeItems.length; i++) {
            items = string(abi.encodePacked(items, 
                _uintToStr(storeItems[i].itemId), ". ", 
                storeItems[i].itemName, ": ", 
                _uintToStr(storeItems[i].cost), " Tokens\n"
            ));
        }
        return items;
    }

    function _initializeStoreItems() internal {
        storeItems.push(StoreItem(1, "Rare Mouse pad", 20));
        storeItems.push(StoreItem(2, "Signed T-shirt", 100));
        storeItems.push(StoreItem(3, "Backpack", 150));
        storeItems.push(StoreItem(4, "PS5", 300));
        storeItems.push(StoreItem(5, "Exclusive trip", 400));
    }

    function _getItemCost(uint256 itemId) internal view returns (uint256) {
        for (uint i = 0; i < storeItems.length; i++) {
            if (storeItems[i].itemId == itemId) {
                return storeItems[i].cost;
            }
        }
        revert("Invalid item ID.");
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    function _uintToStr(uint _i) internal pure returns (string memory) {
        if (_i == 0) return "0";
        uint j = _i;
        uint len;
        while (j != 0) { len++; j /= 10; }
        bytes memory bstr = new bytes(len);
        uint k = len;
        while (_i != 0) {
            k--;
            bstr[k] = bytes1(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);
    }
}
