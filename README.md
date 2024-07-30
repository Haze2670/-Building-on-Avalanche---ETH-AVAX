# -Building-on-Avalanche---ETH-AVAX

DegenToken Smart Contract
Overview
The DegenToken contract is an ERC20-based token implemented in Solidity. It extends the ERC20 standard with additional features including token burning, pausing, and a simple store for redeemable items. This contract is built using OpenZeppelin's library to ensure security and best practices.

Features
ERC20 Token: Standard functionality for creating and managing ERC20 tokens.
Burnable: Allows users to burn (destroy) their tokens.
Pausable: Enables the contract owner to pause and unpause the contract, halting all token transfers and other state-changing operations.
ReentrancyGuard: Prevents reentrancy attacks on sensitive functions.
Store Items: Users can redeem tokens for predefined store items.
Contract Details
Name: Haze
Symbol: HZE
Decimals: 0 (No fractional tokens)
Functions
Minting
mint(address to, uint256 amount): Mints new tokens to the specified address. Callable only by the contract owner and when not paused.
Token Transfer
transferTokens(address receiver, uint256 value): Transfers tokens from the sender to the receiver. Callable when not paused and non-reentrant.
Token Burning
burnTokens(uint256 value): Burns tokens from the sender’s account. Callable when not paused and non-reentrant.
Token Redemption
redeemTokens(uint256 itemId): Allows users to redeem tokens for items from the store. The item’s cost is burned from the user’s balance. Callable when not paused and non-reentrant.
Balance Queries
getBalance(): Returns the balance of the sender’s account.
getBalanceOf(address account): Returns the balance of the specified account.
Store Items
showStoreItems(): Displays a list of available store items, their IDs, names, and costs in tokens.
Contract Control
pause(): Pauses the contract, disabling state-changing functions. Callable only by the contract owner.
unpause(): Unpauses the contract, re-enabling state-changing functions. Callable only by the contract owner.
Store Items
The following items are available for redemption:

Rare Mouse pad - 20 Tokens
Signed T-shirt - 100 Tokens
Backpack - 150 Tokens
PS5 - 300 Tokens
Exclusive trip - 400 Tokens
Usage
Deployment
Deploy the contract using Remix, selecting the appropriate Solidity version (0.8.20 or higher) and configuring the environment to use the desired network (e.g., Remix VM, Injected Web3).

Interaction
After deployment, interact with the contract using the provided functions. Ensure the contract is not paused to perform transactions.

Security
This contract uses OpenZeppelin’s well-tested contracts for security. However, always review and test thoroughly before deploying to production.

Author
Raymark

License
This contract is licensed under the MIT License. See the LICENSE file for details.
