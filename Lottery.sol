// SPDX-License-Identifier: MIT

pragma solidity >=0.4.0 <0.9.0;

/**
 * Lottery Application Smart Contract
 * This contracts allows an admin to create a customizable lottery
 * The admin of the lottery will lookout for each trasacion and select the winner of the lottery on a random basis
 */
 contract LotteryApplication {

     address public admin;
     address payable[] public participants;

     constructor() {
         admin = msg.sender;
     }

     receive() external payable {
         require(msg.value == 0.1 ether);
         participants.push(payable(msg.sender));
     }

     function getBalance() public view returns(uint){
         require(msg.sender == admin);
         return address(this).balance;
     }

     function random() public view returns(uint){
         return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, participants.length)));
     }

     function Winner() public {
         require(msg.sender == admin);
         require(participants.length >= 3);
         address payable winner;
         uint r = random();
         uint index = r % participants.length;
         winner = participants[index];
         winner.transfer(getBalance());
     }
 }
