// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    address public treasury;

    constructor(address _treasury) ERC20("FeeToken", "FEE") {
        treasury = _treasury;
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function _update(address from, address to, uint256 value) internal virtual override {
        if (from == address(0) || to == address(0)) {
            super._update(from, to, value);
            return;
        }

        uint256 fee = value / 100; // 1% de comisión
        uint256 amountAfterFee = value - fee;

        super._update(from, to, amountAfterFee);

        if (fee > 0) {
            super._update(from, treasury, fee);
        }
    }
}
