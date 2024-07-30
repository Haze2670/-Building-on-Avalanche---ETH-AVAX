# -Building-on-Avalanche---ETH-AVAX

1. Open Remix IDE 
Navigate to Remix: Open your browser and go to Remix IDE.

2. Create a New File

Create a New File: In the Remix IDE, go to the "File Explorers" tab on the left sidebar and click on the "+" icon to create a new file.
Name the File: Enter DegenToken.sol as the filename and click "OK".

3. Paste The code

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


4. Compile the Contract
Open the Solidity Compiler: Click on the "Solidity Compiler" tab on the left sidebar (the one with the Solidity logo).
Select Compiler Version: Ensure the compiler version matches 0.8.20. If not, select the correct version from the dropdown menu.
Compile: Click on the "Compile DegenToken.sol" button to compile your contract.

5. Deploy the Contract
Open the Deploy & Run Transactions Tab: Click on the "Deploy & Run Transactions" tab on the left sidebar.
Environment: Select "Remix VM (London)" from the Environment dropdown. This will deploy the contract to a simulated Ethereum network.
Deploy: Click on the "Deploy" button. This will deploy your DegenToken contract to the Remix VM.

6. Interact with the Contract
Once the contract is deployed, you will see it listed under "Deployed Contracts" in the "Deploy & Run Transactions" tab. You can now interact with your contract using the available functions:

Mint Tokens: Use the mint function to create new tokens and assign them to a specific address. Input the address and amount, then click "transact".
Transfer Tokens: Use the transferTokens function to send tokens from your address to another. Input the receiver address and amount, then click "transact".
Burn Tokens: Use the burnTokens function to burn tokens from your account. Input the amount and click "transact".
Redeem Tokens: Use the redeemTokens function to redeem tokens for store items. Input the item ID and click "transact".
Get Balance: Use the getBalance function to view your token balance. Click "call" to see the result.
Show Store Items: Use the showStoreItems function to display available store items. Click "call" to see the list of items.

7. Test and Debug
Test Functionality: Perform various operations to test the contract’s functionality, such as minting tokens, transferring, burning, and redeeming.
Debug: Use the Remix debugger if you encounter any issues. Click on the "Debugger" tab to analyze transactions.

Summary
Open Remix IDE.
Create a new file and paste your smart contract code.
Compile the contract using the correct Solidity version.
Deploy the contract to the Remix VM.
Interact with the contract using provided functions.
Test and debug as needed.

Author
Raymark

License
This contract is licensed under the MIT License. See the LICENSE file for details.
