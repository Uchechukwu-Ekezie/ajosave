// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {BaseSafeFactory} from "../src/BaseSafeFactory.sol";
import {BaseToken} from "../src/BaseToken.sol";

contract BaseSafeFactoryTest is Test {
    BaseSafeFactory public factory;
    BaseToken public token;
    address public treasury;
    address public user1;
    address public user2;

    function setUp() public {
        treasury = address(0x100);
        user1 = address(0x1);
        user2 = address(0x2);
        
        token = new BaseToken("Base Safe Token", "BST");
        factory = new BaseSafeFactory(address(token), treasury);
    }

    function test_Deployment() public {
        assertEq(factory.token(), address(token));
        assertEq(factory.treasury(), treasury);
        assertEq(factory.owner(), address(this));
        assertEq(factory.allRotational().length, 0);
        assertEq(factory.allTarget().length, 0);
        assertEq(factory.allFlexible().length, 0);
    }

    function test_DeploymentWithZeroToken() public {
        vm.expectRevert("token 0");
        new BaseSafeFactory(address(0), treasury);
    }

    function test_DeploymentWithZeroTreasury() public {
        vm.expectRevert("treasury 0");
        new BaseSafeFactory(address(token), address(0));
    }
}

