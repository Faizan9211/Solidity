// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract OrganizingEvent{

    struct Event{
        address organizer;
        string name;
        uint date;
        uint price;
        uint ticketOpen;
        uint ticketRemain;
    }
    mapping(uint=>Event) public events;
    mapping(address=>mapping(uint=>uint)) public ticket;
    uint nextId;

    function createEvent(string memory _name,uint _date,uint _price,uint _ticketOpen) public {
        require(_date>block.timestamp,"The Event has over");
        require(_ticketOpen>0,"you can Run the Events");

        events[nextId]=Event(msg.sender,_name,_date,_price,_ticketOpen,_ticketOpen);
        nextId++;
    }

    function buyTicket(uint id,uint quantity) public payable  {
        require(events[id].date>block.timestamp,"The time has loss");
        require(events[id].date!=0,"the ticket has loss");
        Event storage _event=events[id];
        require(msg.value==(_event.price*quantity),"Your not abble to access");
        require(events[id].ticketRemain>=quantity,"Nothing");
        _event.ticketRemain-=quantity;
        ticket[msg.sender][id]+=quantity;
    }

    function transferTicket(uint id,uint quantity,address to) public {
        require(events[id].date>block.timestamp,"The time has loss");
        require(events[id].date!=0,"the ticket has loss");
        require(ticket[msg.sender][id]>=quantity,"Your not enough tickets");
        ticket[msg.sender][id]-=quantity;
        ticket[to][id]+=quantity;
    }




}