// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
contract Contract1{
    uint256 public number; 
    function set(uint _num) public {
        number=_num;
    }
}
contract Contract2{
    Contract1 contract1 = new Contract1(); //creating instance of contract1
    uint public a;
    uint public b= contract1.number();
    function changeValue() public{
          contract1.set(2);
          a=a+1;
    }
}