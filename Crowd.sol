// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract crowdFunding
{
    mapping(address=>uint) public contributors;
    address public manager;
    uint public target;
    uint public miniContribution;
    uint public deadline;
    uint public noOfContributor;
    uint public raisedAmount;

    struct Request{
        string discription;
        address payable recipant;
        uint value;
        bool completed;
        uint noOfVoters;
        mapping(address=>bool) voter;    
    }

    mapping(uint=>Request) public request;
    uint public numRequest;

    constructor (uint _target,uint _deadline)
    {
        target=_target;
        deadline=block.timestamp+_deadline;
        miniContribution=100 wei;
        manager=msg.sender;
    }

    function sendEth() public payable 
    {
        require(block.timestamp<deadline,"Dealine were missing");
        require(msg.value >=miniContribution,"You were not be eligible");

        if (contributors[msg.sender]==0){
            noOfContributor++;
        }
        contributors[msg.sender]+=msg.value;
        raisedAmount+=msg.value;
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }
    function refund() public payable
    {
        require(raisedAmount<target && block.timestamp>deadline);
        require(contributors[msg.sender]<0,"You were Not elgible in Funding");
        address payable user=payable(msg.sender);
        user.transfer(contributors[msg.sender]);
        contributors[msg.sender]=0;
    }

    modifier onlyManager(){
        require (msg.sender==manager,"Only can Access the Function");
        _;
    }

    function createRequest(string memory _discription,address payable _recipant,uint _value) public onlyManager
    {
        Request storage newRequest=request[numRequest];
        numRequest++;
        newRequest.discription=_discription;
        newRequest.recipant=_recipant;
        newRequest.value=_value;
        newRequest.completed=false;
        newRequest.noOfVoters=0;
    } 

    function voteRequest(uint _request) public 
    {
        require(contributors[msg.sender]>0);
        Request storage thisRequest=request[_request];
        require(thisRequest.voter[msg.sender]==false,"Actually you voted");
        thisRequest.voter[msg.sender]=true;
        thisRequest.noOfVoters++;
    }

    function requestAccept(uint _request) public payable onlyManager
    {
        require(raisedAmount<=target);
        Request storage thisRequest=request[_request];
        require(thisRequest.completed==false,"it has completed");
        require(thisRequest.noOfVoters>noOfContributor/2,"Majority does not support");
        thisRequest.recipant.transfer(thisRequest.value);


    }
}