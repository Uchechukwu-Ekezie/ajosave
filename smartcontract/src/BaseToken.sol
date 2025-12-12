// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

/**
 * @title BaseToken
 * @author AjoSave
 * @notice ERC20 token contract used as the base currency for AjoSave savings pools
 * @dev This contract extends OpenZeppelin's ERC20 implementation with owner-controlled minting
 *      and ownership transfer functionality. The token is used across all pool types (Rotational,
 *      Target, and Flexible) as the standard currency for deposits and withdrawals.
 */
contract BaseToken is ERC20 {
    /// @notice Address of the contract owner who can mint tokens and transfer ownership
    address public owner;

    /**
     * @notice Deploys a new BaseToken contract with the specified name and symbol
     * @dev The deployer becomes the initial owner and can mint tokens
     * @param name The name of the token (e.g., "Base Safe Token")
     * @param symbol The symbol of the token (e.g., "BST")
     */
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        owner = msg.sender;
    }

    /**
     * @notice Restricts function access to the contract owner only
     * @dev Reverts if called by any address other than the owner
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    /**
     * @notice Mints new tokens to the specified address
     * @dev Only the owner can mint tokens. This function uses OpenZeppelin's internal _mint function
     *      which automatically updates the total supply and balance.
     * @param to The address that will receive the minted tokens
     * @param amount The amount of tokens to mint (in token's smallest unit)
     * @custom:security This function is protected by the onlyOwner modifier. Ensure the owner
     *                  address is a secure multisig wallet in production deployments.
     */
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    /**
     * @notice Transfers ownership of the contract to a new address
     * @dev Only the current owner can transfer ownership. The new owner must be a non-zero address.
     *      After transfer, the new owner gains the ability to mint tokens and transfer ownership again.
     * @param newOwner The address of the new owner (must not be the zero address)
     * @custom:security Critical function - verify the new owner address before calling. Consider
     *                  using a multisig wallet as the new owner for enhanced security.
     */
    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "New owner is zero address");
        owner = newOwner;
    }
}

