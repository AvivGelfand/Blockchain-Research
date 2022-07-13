// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract WishList {
    struct Item {
        string text;
        bool purchased; // Purchased, completed
    }

    // An array of 'WishList' structs
    Item[] public items; //items

    function create(string calldata _text) public {
        // initialize an empty struct and then update it
        Item memory tobuy;
        tobuy.text = _text;
        // tobuy.completed initialized to false
        items.push(tobuy);
    }

    // Solidity automatically created a getter for 'items' so
    // you don't actually need this function.
    function get(uint _index) public view returns (string memory text, bool purchased) {
        Item storage tobuy = items[_index];
        return (tobuy.text, tobuy.purchased);
    }

    // update text
    function updateText(uint _index, string calldata _text) public {
        Item storage tobuy = items[_index];
        tobuy.text = _text;
    }

    // update completed
    function toggleCompleted(uint _index) public {
        Item storage tobuy = items[_index];
        tobuy.purchased = !tobuy.purchased;
    }

}


