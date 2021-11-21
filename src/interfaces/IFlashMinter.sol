// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IFlashMinter {
    function onFlashMint(
        address sender,
        uint256 amount,
        bytes calldata data
    ) external;
}
