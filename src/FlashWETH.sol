// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "../node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol";

import "./interfaces/IFlashMinter.sol";

contract FlashWETH is ERC20("Flash Wrapped ETH", "fWETH") {
    using SafeMath for uint256;

    receive() external payable {
        deposit();
    }

    function deposit() public payable {
        _mint(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external {
        _burn(msg.sender, amount);

        payable(msg.sender).transfer(amount);
    }

    function flashMint(
        address recipient,
        uint256 amount,
        bytes calldata data
    ) external {
        IFlashMinter flashMinter = IFlashMinter(recipient);
        _mint(recipient, amount);
        flashMinter.onFlashMint(msg.sender, amount, data);
        _burn(recipient, amount);
    }
}
