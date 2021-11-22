// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IFlashMinter.sol";

contract FlashMinter is IFlashMinter {
    uint256 public totalBorrowed;
    address private immutable _controler;
    address private immutable _fWETH;

    constructor(address fWETH) {
        _controler = msg.sender;
        _fWETH = fWETH;
    }

    function onFlashMint(
        address sender,
        uint256 amount,
        bytes calldata data
    ) external override {
        require(msg.sender == _fWETH, "Only the fWETH contract");
        require(sender == _controler, "Only the contract owner");

        totalBorrowed += amount;
    }
}
