// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Campaign {

    struct Request {
        string description;
        uint value;
        address recepient;
        bool complete;
    }

    address public manager;
    uint public minimumContribution;
    address[] public approvers;
    Request[] public requests;

    constructor(uint minimum) {
        minimumContribution = minimum;
        manager = msg.sender;
    }

    function contribute() public  payable  {
        require(msg.value == minimumContribution);
        approvers.push(msg.sender);
    }
}