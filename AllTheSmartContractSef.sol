// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MyMapping {
    // a contract that let attendes vote
    uint256 public attendeesCount;
    address payable[] public attendeesList;
    address payable[] public voteList;
    uint256 public yesVotes;
    uint256 public noVotes;

    mapping(uint256 => address) attendee;
    mapping(address => bool) hasAttended;
    mapping(address => bool) hasVoted;
    mapping(address => bool) voteChoice;

    function openDoor() public {
        // user address will be associated with index
        // address will be added to attendees list
        // emit notified
        // user can't attend more than once
        require(!hasAttended[msg.sender], "your name has been recorded");

        attendee[attendeesCount] = msg.sender;
        attendeesList.push(payable(attendee[attendeesCount]));
        attendeesCount++;
        hasAttended[msg.sender] = true;
    }

    function yesVote() public {
        require(!hasVoted[msg.sender], "you have already voted");
        yesVotes++;

        hasVoted[msg.sender] = true;
        voteChoice[msg.sender] = true;
        voteList.push(payable(msg.sender));
    }

    function noVote() public {
        require(!hasVoted[msg.sender], "you have already voted");
        noVotes++;

        hasVoted[msg.sender] = true;
        voteChoice[msg.sender] = false;
        voteList.push(payable(msg.sender));
    }

    function retrieve() public view returns (address payable[] memory) {
        return voteList;
    }
}
