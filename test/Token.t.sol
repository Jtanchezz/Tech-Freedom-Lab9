// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Token} from "../src/Token.sol";

contract TokenTest is Test {
    Token public token;
    address public owner = address(1);
    address public treasury = address(2);
    address public alice = address(3);
    address public bob = address(4);

    function setUp() public {
        vm.startPrank(owner);
        token = new Token(treasury);
        token.transfer(alice, 10000 * 10 ** token.decimals());
        vm.stopPrank();
    }

    // Unit Test: Verifica valores estáticos
    function test_transfer_sends_fee() public {
        uint256 amount = 1000 * 10 ** token.decimals();

        uint256 treasuryBalanceBefore = token.balanceOf(treasury);

        vm.prank(alice);
        token.transfer(bob, amount);

        uint256 expectedFee = amount / 100;
        uint256 expectedAmount = amount - expectedFee;

        assertEq(token.balanceOf(bob), expectedAmount);
        assertEq(token.balanceOf(treasury), treasuryBalanceBefore + expectedFee);
    }

    // Fuzz Test: Verifica montos aleatorios
    function testFuzz_transfer(uint256 amount) public {
        amount = bound(amount, 100, token.balanceOf(alice));

        uint256 treasuryBalanceBefore = token.balanceOf(treasury);

        vm.prank(alice);
        token.transfer(bob, amount);

        uint256 expectedFee = amount / 100;
        uint256 expectedAmount = amount - expectedFee;

        assertEq(token.balanceOf(bob), expectedAmount);
        assertEq(token.balanceOf(treasury), treasuryBalanceBefore + expectedFee);
    }
}
