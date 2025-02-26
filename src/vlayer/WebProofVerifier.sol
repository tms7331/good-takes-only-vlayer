// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {WebProofProver} from "./WebProofProver.sol";
import {Proof} from "vlayer-0.1.0/Proof.sol";
import {Verifier} from "vlayer-0.1.0/Verifier.sol";

contract WebProofVerifier is Verifier {
    address public prover;
    mapping(string => bool) public approved;

    constructor(address _prover) {
        prover = _prover;
    }

    function verify(
        Proof calldata,
        string memory hashedPass
    ) public onlyVerified(prover, WebProofProver.main.selector) {
        // This logic needs to be in the other
        // require(
        //     keccak256(abi.encodePacked(judgement)) ==
        //         keccak256(abi.encodePacked("good")),
        //     "Response must be 'good'"
        // );
        approved[hashedPass] = true;
    }

    function verifyT(string memory hashedPass) public {
        require(
            keccak256(abi.encodePacked(judgement)) ==
                keccak256(abi.encodePacked("good")),
            "Response must be 'good'"
        );
        approved[hashedPass] = true;
    }
}
