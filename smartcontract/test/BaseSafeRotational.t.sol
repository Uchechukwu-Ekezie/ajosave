// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {BaseSafeRotational} from "../src/BaseSafeFactory.sol";
import {BaseToken} from "../src/BaseToken.sol";

contract BaseSafeRotationalTest is Test {
    BaseSafeRotational public pool;
    BaseToken public token;
    address public treasury;
    address public user1;
    address public user2;
    address public user3;

    function setUp() public {
        treasury = address(0x100);
        user1 = address(0x1);
        user2 = address(0x2);
        user3 = address(0x3);
        
        token = new BaseToken("Base Safe Token", "BST");
        
        address[] memory members = new address[](3);
        members[0] = user1;
        members[1] = user2;
        members[2] = user3;
        
        pool = new BaseSafeRotational(
            address(token),
            members,
            100e18, // depositAmount
            7 days, // roundDuration
            100, // treasuryFeeBps (1%)
            50, // relayerFeeBps (0.5%)
            treasury
        );
    }

    function test_Deployment() public {
        assertEq(address(pool.token()), address(token));
        assertEq(pool.treasury(), treasury);
        assertEq(pool.totalMembers(), 3);
        assertEq(pool.depositAmount(), 100e18);
        assertEq(pool.roundDuration(), 7 days);
        assertEq(pool.treasuryFeeBps(), 100);
        assertEq(pool.relayerFeeBps(), 50);
        assertEq(pool.currentRound(), 0);
        assertTrue(pool.active());
    }

    function test_DeploymentWithInvalidParams() public {
        address[] memory members = new address[](1);
        members[0] = user1;
        
        vm.expectRevert("need >=2 members");
        new BaseSafeRotational(address(token), members, 100e18, 7 days, 100, 50, treasury);
    }
}

