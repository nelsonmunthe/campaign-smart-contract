// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Campaign {

    struct Request {
        string description;
        uint value;
        address recepient;
        bool completed;
    }

    address public manager;
    uint public minimumContribution;
    address[] public approvers;
    Request[] public requests;

    modifier  resctricted () {
        require(msg.sender == manager, "only manager can do");
        _;
    }

    constructor(uint minimum) {
        minimumContribution = minimum;
        manager = msg.sender;
    }

    function contribute() public  payable  {
        require(msg.value == minimumContribution);
        approvers.push(msg.sender);
    }

    function createRequest(string memory description, uint value, address recepient) public  resctricted {
        Request memory newRequest = Request({
            description: description,
            value: value,
            recepient: recepient,
            completed: false
        });

        requests.push(newRequest);
    }
}