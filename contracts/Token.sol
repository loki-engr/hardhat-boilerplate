//SPDX-License-Identifier: UNLICENSED

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.9;

// We import this library to be able to use console.log
import "hardhat/console.sol";

// This is the main building block for smart contracts.
error EtherTransfer_failed();

contract Token {
    // Some string type variables to identify the token.
    string public name1 = "My Hardhat Token1";
    string public symbol1 = "MHT1";
    string public name2 = "My Hardhat Token2";
    string public symbol2 = "MHT2";
    string public name3 = "My Ether";
    string public symbol3 = "METH";

    // The fixed amount of tokens stored in an unsigned integer type variable.
    uint256 public totalSupply = 1000000;

    // An address type variable is used to store ethereum accounts.
    address public owner;

    // A mapping is a key/value map. Here we store each account balance.
    mapping(address => uint256) balances1;
    mapping(address => uint256) balances2;

    // The Transfer event helps off-chain aplications understand
    // what happens within your contract.
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _amount1,
        uint256 _amount2,
        uint256 value
    );

    /**
     * Contract initialization.
     */
    constructor() {
        // The totalSupply is assigned to the transaction sender, which is the
        // account that is deploying the contract.
        balances1[msg.sender] = totalSupply;
        balances2[msg.sender] = totalSupply;

        owner = msg.sender;
    }

    /**
     * A function to transfer tokens.
     *
     * The `external` modifier makes a function *only* callable from outside
     * the contract.
     */
    function transfer(
        address to,
        uint256 amount1,
        uint256 amount2
    ) external payable {
        // Check if the transaction sender has enough tokens.
        // If `require`'s first argument evaluates to `false` then the
        // transaction will revert.
        require(balances1[msg.sender] >= amount1, "Not enough token1");
        require(balances2[msg.sender] >= amount2, "Not enough token2");

        // We can print messages and values using console.log, a feature of
        // Hardhat Network:
        console.log("Transferring from %s to %s", msg.sender, to);

        // Transfer the amount.
        balances1[msg.sender] -= amount1;
        balances1[to] += amount1;
        balances2[msg.sender] -= amount2;
        balances2[to] += amount2;
        if (msg.value > 0) {
            (bool success, ) = payable(to).call{value: msg.value}("");
            if (!success) revert EtherTransfer_failed();
        }

        // Notify off-chain applications of the transfer.
        emit Transfer(msg.sender, to, amount1, amount2, msg.value);
    }

    /**
     * Read only function to retrieve the token balance of a given account.
     *
     * The `view` modifier indicates that it doesn't modify the contract's
     * state, which allows us to call it without executing a transaction.
     */
    function balanceOfToken1(address account) external view returns (uint256) {
        return balances1[account];
    }

    function balanceOfToken2(address account) external view returns (uint256) {
        return balances2[account];
    }
}
