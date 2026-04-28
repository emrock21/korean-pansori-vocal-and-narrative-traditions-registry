// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract PansoriVocalTraditionsRegistry {

    struct PansoriTradition {
        string repertoire;          // Chunhyangga, Heungbuga, etc.
        string vocalTechniques;     // sori, aniri, chuimsae
        string gestures;            // ballim, expressive movement
        string region;              // Jeolla, Gyeongsang, Seoul
        string accompaniment;       // buk drum styles
        string culturalContext;     // performances, rituals, training lineage
        string uniqueness;          // UNESCO status, regional school identity
        address creator;
        uint256 likes;
        uint256 dislikes;
        uint256 createdAt;
    }

    struct PansoriInput {
        string repertoire;
        string vocalTechniques;
        string gestures;
        string region;
        string accompaniment;
        string culturalContext;
        string uniqueness;
    }

    PansoriTradition[] public traditions;
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    event PansoriRecorded(uint256 indexed id, string repertoire, address indexed creator);
    event PansoriVoted(uint256 indexed id, bool like, uint256 likes, uint256 dislikes);

    constructor() {
        traditions.push(
            PansoriTradition({
                repertoire: "Example (replace manually)",
                vocalTechniques: "example",
                gestures: "example",
                region: "example",
                accompaniment: "example",
                culturalContext: "example",
                uniqueness: "example",
                creator: address(0),
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );
    }

    function recordPansori(PansoriInput calldata p) external {
        traditions.push(
            PansoriTradition({
                repertoire: p.repertoire,
                vocalTechniques: p.vocalTechniques,
                gestures: p.gestures,
                region: p.region,
                accompaniment: p.accompaniment,
                culturalContext: p.culturalContext,
                uniqueness: p.uniqueness,
                creator: msg.sender,
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );

        emit PansoriRecorded(traditions.length - 1, p.repertoire, msg.sender);
    }

    function votePansori(uint256 id, bool like) external {
        require(id < traditions.length, "Invalid ID");
        require(!hasVoted[id][msg.sender], "Already voted");

        hasVoted[id][msg.sender] = true;
        PansoriTradition storage p = traditions[id];

        if (like) p.likes++;
        else p.dislikes++;

        emit PansoriVoted(id, like, p.likes, p.dislikes);
    }

    function totalPansori() external view returns (uint256) {
        return traditions.length;
    }
}
