// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract piggybank{
    event Deposit(uint amount);
    event Withdraw (uint amount);
    address public owner=msg.sender;

    receive() external payable{
        emit Deposit(msg.value);
    }

    function withdraw() public payable{
        require(msg.sender==owner,"Your not able");
        emit Withdraw(address(this).balance);
    }
    // function getBaln() public view returns(uint){
    //     return address(this).balance;
    // }
}