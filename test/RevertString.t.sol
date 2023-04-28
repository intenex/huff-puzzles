// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {HuffConfig} from "foundry-huff/HuffConfig.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {console} from "forge-std/console.sol";

interface RevertString {}

contract RevertStringTest is Test {
    RevertString public revertString;
    event LogCalldata(bytes);

    function setUp() public {
        revertString = RevertString(
            HuffDeployer.config().deploy("RevertString")
        );
    }

    function testRevertString() public {
        (bool success, bytes memory revertData) = address(revertString).call(
            ""
        );
        emit LogCalldata(revertData);
        require(!success, "call expected to fail");
        assertEq(
            keccak256(bytes("Only Huff")),
            keccak256(revertData),
            "Expected the call to revert with custom error 'Only Huff' but it didn't "
        );
    }
}
