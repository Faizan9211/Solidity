// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Vender{

    address public owner;
    mapping(address=>uint) public donutsBalance;

    constructor() {
        owner=msg.sender;
        donutsBalance[address(this)]=100;
    }

    function restock(uint amount) public {
        require(msg.sender==owner,"Sorry the owner");
        donutsBalance[address(this)]+=amount;
    }

    function getDonutBalance() public view returns(uint){        
        return donutsBalance[address(this)];

    }

    function purchace(uint amount) public payable {
        require(msg.value==(2 ether*amount),"Sorry your not enough money");
        require(donutsBalance[address(this)]>=amount,"Sorry Donuts have finished");
        donutsBalance[address(this)]-=amount;
        donutsBalance[msg.sender]+=amount;
    }
}