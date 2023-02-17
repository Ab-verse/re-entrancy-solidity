// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract EtherStore {
    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint bal = balances[msg.sender];
        require(bal > 0);

        // to prevent re-entracy uncomment bellow line  

        // balances[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Ether");

        // and comment this below line
        balances[msg.sender] = 0;
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}


/*

Preventative Techniques:

1. Ensure all state changes happen before calling external contracts
2. Use function modifiers that prevent re-entrancy

Here is a example of a re-entracy guard



pragma solidity ^0.8.17;

contract ReEntrancyGuard {
    bool internal locked;

    modifier noReentrant() {
        require(!locked, "No re-entrancy");
        locked = true;
        _;
        locked = false;
    }
}

*/
