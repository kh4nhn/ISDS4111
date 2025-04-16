// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SpaceshipRental {

    address payable public owner;
    bool public available;
    uint public ratePerDay;

    event Log(address indexed sender, string message);

    constructor() {
        owner = payable(msg.sender);
        available = true;
        ratePerDay = 0.5 ether;
    }

    modifier onlyOwner () {
        require(msg.sender == owner, "Only owner can run this method, loser.");
       _;
    }

    modifier notAvailable() {
    require(available, "My spaceship is being used right now hahaha.");
    _;
}

    function rentSpceShp(uint numDays) public payable notAvailable {
    uint minOffer = ratePerDay * numDays;
    require(msg.value >= minOffer, "You are too poor to afford my spaceship!");
    (bool sent, ) = payable(owner).call{ value: msg.value }("");
    require(sent, "Payment failed.");
    available = false;
}

    function makeSpceShpAvail() public onlyOwner{
        available = true;
    }   

    function updateRate(uint newRate) public onlyOwner{
        ratePerDay = newRate;
        emit Log(msg.sender, "Space Ship Rate Updated To");
    }

    function buySpaceShip () public payable{
       uint minSellOffer = (3 * 365) * ratePerDay;
        require (msg.value >= minSellOffer, " You fr rn? gtfo you brokie");
        (bool sent, ) = payable(owner).call{value: msg.value}("");
        require (sent, "Brokie!");
        available = (false);

    }

}
