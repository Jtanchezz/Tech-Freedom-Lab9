// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {Token} from "../src/Token.sol";

contract DeployScript is Script {
    function run() external returns (Token) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        // Si el constructor requiere una dirección (ej. treasury/owner):
        Token token = new Token(deployerAddress);

        // NOTA: Si el constructor requiere un monto (ej. initial supply de 1M de tokens), usa:
        // Token token = new Token(1000000 * 1e18);

        vm.stopBroadcast();

        console.log("Token desplegado exitosamente en:", address(token));

        return token;
    }
}
