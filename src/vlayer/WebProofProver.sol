// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {Strings} from "@openzeppelin-contracts-5.0.1/utils/Strings.sol";

import {Proof} from "vlayer-0.1.0/Proof.sol";
import {Prover} from "vlayer-0.1.0/Prover.sol";
import {Web, WebProof, WebProofLib, WebLib} from "vlayer-0.1.0/WebProof.sol";

contract WebProofProver is Prover {
    using Strings for string;
    using WebProofLib for WebProof;
    using WebLib for Web;

    // string public constant DATA_URL =
    //     "https://api.x.com/1.1/account/settings.json";
    //string constant DATA_URL = "https://openrouter.ai/api/v1/chat/completions";
    string constant DATA_URL =
        "https://good-takes-only-frontend.vercel.app/api/chat";

    function main(
        WebProof calldata webProof
    ) public view returns (Proof memory) {
        Web memory web = webProof.verify(DATA_URL);

        // string memory screenName = web.jsonGetString("screen_name");
        // This string should be 'good' or 'bad'
        // string memory judgement = web.jsonGetString(
        //     "choices[0].message.content"
        // );
        string memory judgement = web.jsonGetString("response");
        require(
            keccak256(abi.encodePacked(judgement)) ==
                keccak256(abi.encodePacked("good")),
            "Response must be 'good'"
        );
        return (proof());
    }
}
