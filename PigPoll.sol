//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;

contract PigPoll {
    address public owner;
    uint public totalVote;
    Candidate[] public candidates;

    struct Candidate {
        string name;
        uint countVote;
    }

    struct Voter {
        bool authorized;
        uint whom;
        bool voted;
    }

    mapping(address => Voter) public voters;

    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
    }
    
    function addCandidate(string memory _candidate) public isOwner {
        candidates.push(Candidate(_candidate, 0));
    }

    function voterRegister() public {
        voters[msg.sender].authorized = true; 
    }

    function getTotalVote() public view returns(uint) {
        return totalVote;
    }

    function getTotalCandidate() public view returns(uint) {
        return candidates.length;
    }

    function getCandidateInfo(uint _id) public view returns(Candidate memory) {
        return candidates[_id];
    }

    function vote(uint _id) public {
        require(!voters[msg.sender].voted);
        require(voters[msg.sender].authorized);
        voters[msg.sender].whom = _id;
        voters[msg.sender].voted = true;
        candidates[_id].countVote++;
        totalVote++;
    }
}
