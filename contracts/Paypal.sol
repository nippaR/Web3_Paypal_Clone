// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Paypal {

//Define the owner of the smart contract

    address public owner;

    constructor(){
        owner = msg.sender;
    }

//Create Struct and Mapping for request, transaction & name

    struct request {
        address requestor;
        uint256 amount;
        string message;
        string name;
    }

    struct sendReceive {
        string action;
        uint256 amount;
        string message;
        address sender;
        address otherPartyAddress;
        string otherPartyName;
    }

    struct userName {
        string name;
        bool hasName;
    }

    mapping(address => userName) names;
    mapping(address => request[]) requests;
    mapping(address => sendReceive[]) history;

//Add a name to wallet address

    function addName(string memory _name) public {

        userName storage newUserName = names[msg.sender];
        newUserName.name = _name;
        newUserName.hasName = true;
    }

//create a Request

    function createRequest(address user, uint256 _amount, string memory _message) public {

        request memory newRequest;
        newRequest.requestor = msg.sender;
        newRequest.amount = _amount;
        newRequest.message = _message;
        if(names[msg.sender].hasName){
            newRequest.name = names[msg.sender].name;
        }
        requests[user].push(newRequest);
    }

//Pay a Request

    function payRequest(uint256 _request) public payable {

        require(_request < requests[msg.sender].length, "No such request exists");
        request[] storage myRequests = requests[msg.sender];
        request storage payableRequest = myRequests[_request];

        uint256 toPay = payableRequest.amount * 1000000000000000000;
        require(msg.value >= (toPay), "pay correct amount");
    
        payable(payableRequest.requestor).transfer(msg.value);

        addHistory(msg.sender, payableRequest.requestor, payableRequest.amount, payableRequest.message);

        myRequests[_request] = myRequests[myRequests.length - 1];
        myRequests.pop();
    }

//Add a transaction to history

    function addHistory(address sender, address receiver, uint256 _amount, string memory _message) private {

        sendReceive memory newSend;
        newSend.action = "-";
        newSend.amount = _amount;
        newSend.message = _message;
        newSend.otherPartyAddress = receiver;
        if(names[receiver].hasName){
            newSend.otherPartyName = names[receiver].name;
        }
        history[sender].push(newSend);

        sendReceive memory newReceive;
        newReceive.action = "+";
        newReceive.amount = _amount;
        newReceive.message = _message;
        newReceive.otherPartyAddress = sender;
        if(names[sender].hasName){
            newReceive.otherPartyName = names[sender].name;
        }
        history[receiver].push(newReceive);
    }


//Get all requests send to a User

    function getMyRequests(address _user) public view returns (
        address[] memory,
        uint256[] memory,
        string[] memory,
        string[] memory
    ){
        address[] memory addrs = new address[](requests[_user].length);
        uint256[] memory amnt = new uint256[](requests[_user].length);
        string[] memory msge  = new string[](requests[_user].length);
        string[] memory nme = new string[](requests[_user].length);

        for (uint i = 0; i < requests[_user].length; i++) {
            request storage myRequests = requests[_user][i];
            addrs[i] = myRequests.requestor;
            amnt[i] = myRequests.amount;
            msge[i] = myRequests.message;
            nme[i] = myRequests.name;
        }

        return (addrs, amnt, msge, nme);

    }

//Get all historic transactions user has been apart of


    function getMyHistory(address _user) public view returns(sendReceive[] memory){
            return history[_user];
        }

//Get the name of a user

    function getMyName(address _user) public view returns(string memory){
        return names[_user].name;
    }
}