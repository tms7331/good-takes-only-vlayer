/*

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {VTest} from "vlayer-0.1.0/testing/VTest.sol";
import {WebProof, Web} from "vlayer-0.1.0/WebProof.sol";
import {Proof} from "vlayer-0.1.0/Proof.sol";
import {Strings} from "@openzeppelin-contracts-5.0.1/utils/Strings.sol";

import {WebProofProver} from "../../src/vlayer/WebProofProver.sol";

contract WebProverTest is VTest {
    using Strings for string;

    function test_verifiesWebProofAndRetrievesScreenName() public {
        WebProof memory webProof = WebProof(vm.readFile("testdata/web_proof.json"));
        WebProofProver prover = new WebProofProver();
        address account = vm.addr(1);

        callProver();
        (, string memory screenName, address addr) = prover.main(webProof, account);

        assert(screenName.equal("g_p_vlayer"));
        assertEq(addr, account);
    }

    function test_failedVerificationBecauseOfBadWebProofSignature() public {
        WebProof memory webProof = WebProof(vm.readFile("testdata/bad_web_proof_signature.json"));
        WebProofProver prover = new WebProofProver();
        address account = vm.addr(1);

        callProver();
        try prover.main(webProof, account) returns (Proof memory, string memory, address) {
            revert("Expected error");
        } catch Error(string memory reason) {
            assertEq(
                reason,
                "Preflight: Execution error: EVM error: Verification error: Presentation error: presentation error: attestation error caused by: attestation proof error: signature error caused by: signature verification failed: secp256k1 signature verification failed"
            );
        }
    }
}

*/