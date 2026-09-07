// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, StdInvariant} from "forge-std/Test.sol";
import {Token} from "../src/Token.sol";

contract InvariantTest is Test {
    Token public token;
    address public treasury = address(2);

    function setUp() public {
        token = new Token(treasury);
        
        // Le indicamos a Foundry qué contrato monitorear para las llamadas aleatorias
        targetContract(address(token));
    }

    // Invariante: El suministro total de tokens nunca debe cambiar por cobrar comisiones
    function invariant_totalSupplyConstant() public view {
        assertEq(token.totalSupply(), 1000000 * 10 ** token.decimals());
    }
}
