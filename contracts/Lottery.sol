// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Lottery{
    address public manager;
    address payable[] public players;
    address payable public winner;

    constructor(){
        manager=msg.sender;
    }

    function participate() public payable{
        require(msg.value==10 wei,"Participation requires exactly 10 wie.");
        players.push(payable (msg.sender));
    }

    function getBalance() public view returns(uint){
        require(msg.sender==manager,"Access denied: Only the manager can view the balance.");
        return address(this).balance;
    }

    function random() internal view returns(uint){
        return uint(keccak256(abi.encodePacked(block.prevrandao ,block.timestamp,players.length)));
    }

    function getWinner() public {
        require(msg.sender == manager, "Access denied: Only the manager can select the winner.");
        require(players.length >= 3, "Insufficient players: At least 3 players are required to draw a winner.");

        uint r = random();
        uint index = r%players.length;
        winner = players[index];
        winner.transfer(getBalance());
        players = new address payable[](0);
    }
}