// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract maasage{
    event balance(address manager,string name,uint val);

    function getter(uint _val) public {
        emit balance (msg.sender,"Kya haal",_val);
    }
}

contract chat{
    event chatBox(address _from,address _to,string mssg);

    function sendmsg(address _to,string memory _mssg) public{
        emit chatBox(msg.sender,_to,_mssg);
    }
}