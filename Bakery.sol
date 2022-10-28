// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract bakery{
    address payable salesMan=payable (0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);
    address public owner;
    uint c = 3166282360;

    constructor()
    {
        owner=msg.sender;
    }

    function getter() public payable 
    {

    }

    function getBlance() view public returns(uint)
    {
        return address(this).balance;
    }

    receive() external payable
    {
        require(msg.sender==owner);
    }

    function getMeal(uint a) view public returns(bool)
    {
        if (a == c){
            return true;
        }
        return false;
    }

    function getOrder() public payable 
    {
        // require(getMeal() == true);
        // require(msg.value >= 3 ether);
        salesMan.transfer(getBlance());
    }
}