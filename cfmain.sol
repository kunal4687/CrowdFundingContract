// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.18;

contract Crowdfunding {
    
    address payable public creator;
    uint public goal;
    uint public raised;
    mapping(address => uint) public contributors;
    
    constructor(uint _goal) {
        creator = payable(msg.sender);
        goal = _goal;
    }
    
    function contribute() public payable {
        require(msg.value > 0, "Contribution must be greater than 0");
        raised += msg.value;
        contributors[msg.sender] += msg.value;
        if (raised >= goal) {
            creator.transfer(raised);
            raised = 0;
        }
    }
    
    function withdraw() public {
        require(msg.sender == creator, "Only creator can withdraw funds");
        creator.transfer(address(this).balance);
    }
    
}
