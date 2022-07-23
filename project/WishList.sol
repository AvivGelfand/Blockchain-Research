// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract WishListTest {
    address owner; 
    constructor() { 
        owner = msg.sender; 
        // address that deploys contract will be the owner 
    } 

    bool isSharing = false;

    struct Item {
        string text;
        bool purchased; // Purchased or not
    }
    struct Wishlist{
        Item[] items;
        bool isSharing;
    }

    // An array of 'WishList' structs
    mapping( address =>  Wishlist)  public WishLists;

    function toggleShare() public {
        require(msg.sender == owner);
        WishLists[msg.sender].isSharing = !isSharing;
    }

    function create(string calldata _text) public {
        // initialize an empty struct and then update it
        // require(whitelist.isMember(account), "Account not whitelisted.");
        Item memory newItem;
        newItem.text = _text;
        // tobuy.completed initialized to false
        WishLists[msg.sender].items.push(newItem);
    }

   
    // get:
    // Solidity automatically created a getter for 'items' so
    // you don't actually need this function.
    event test_value(bool value1);

    function get(address _customer, uint _index) public view returns (string memory text, bool purchased)
    {
        // println("Test");
        bool isSharing1 = WishLists[_customer].isSharing;

        require(isSharing1, "User is not sharing, sorry!");
        
        Item storage item = WishLists[_customer].items[_index];
        return (item.text, item.purchased);
    }

    function getIsSharing()

    //Later on make it a get list function.

} //End Wishlist
