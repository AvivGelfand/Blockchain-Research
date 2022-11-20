// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// interface IERC721 {
//     function safeTransferFrom(
//         address from,
//         address to,
//         uint tokenId
//     ) external;

//     function transferFrom(
//         address,
//         address,
//         uint
//     ) external;
// }

contract EnglishAuction {
    event Start();
    event Bid(address indexed sender, uint amount);
    event Withdraw(address indexed bidder, uint amount);
    event End(address winner, uint amount);

    uint public age;
    uint public customerId;
    uint public quantity;

    address payable public seller;
    uint public endAt;
    bool public started;
    bool public ended;

    address public highestBidder;
    // address public highestBidder;

    uint public highestBid;
    mapping(address => uint) public bids;
    mapping(address => uint) public asks;

    constructor(
        uint _age,
        uint _customerId,
        uint _startingBid,
        uint _quantity
    ) {
        age = _age;
        customerId = _customerId;
        quantity = _quantity;
        seller = payable(msg.sender);
        highestBid = _startingBid;
    }

    function start() external {
        require(!started, "started");
        require(msg.sender == seller, "not seller");


        // nft.transferFrom(msg.sender, address(this), customerId);
        started = true;
        endAt = block.timestamp + 7 days;

        emit Start();
    }

    function bid() external payable {
        require(started, "not started");
        require(block.timestamp < endAt, "ended");
        require(msg.value > highestBid, "value < highest");

        if (highestBidder != address(0)) {
            bids[highestBidder] += highestBid;
        }

        highestBidder = msg.sender;
        highestBid = msg.value;

        emit Bid(msg.sender, msg.value);
    }

    function withdraw() external {
        uint bal = bids[msg.sender];
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(bal);

        emit Withdraw(msg.sender, bal);
    }

    function end() external {
        require(started, "not started");
        require(block.timestamp >= endAt, "not ended");
        require(!ended, "ended");

        ended = true;
        if (highestBidder != address(0)) {
            // nft.safeTransferFrom(address(this), highestBidder, customerId);
            
            seller.transfer(highestBid);
        } else {
            // nft.safeTransferFrom(address(this), seller, customerId);
        }

        emit End(highestBidder, highestBid);
    }
}
