// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;


contract CustomerPreferences {
    
    // Eevents
    event GrantRole(bytes32 indexed role, address indexed account);
    // event RevokeRole(bytes32 indexed role, address indexed account);
    
    event SetShare(bool indexed share, address indexed account);

    // Prefrences Array: prefersnce => account => bool
    // mapping(bytes32 => mapping ( address => bool) ) public prefrencess;
    // we save gas by mapping the name to numbers
        
    // role => account => bool
    mapping(bytes32 => mapping ( address => bool) ) public roles;
    // we save gas by mapping the names to numbers
    
    // 0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96 // private
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));
    // USER

    // 0x6b930a54bc9a8d9d32021a28e2282ffedf33210754271fcab1eb90abc2021a1c // private
    // bytes32 public constant COMPANY = keccak256(abi.encodePacked("COMPANY"));
    
    // This line checks if the 
    modifier onlyRole(bytes32 _role){
        require (roles[_role][msg.sender], "not authorised");
        _;
    }

    // need to modify constructor
    constructor() {
        _grantRole(USER, msg.sender); //LATER WILL CALL AC CONTRACT
    }

    function _grantRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = true;
        emit GrantRole(_role, _account);
    }


    bool private ShareWishList = false;
        
     // USER setting HIDE / SHOW:
    function _setPref(bool _toshare) internal {
        emit SetShare(_toshare, msg.sender);
    }

    function setPref(bool _toshare) external  onlyRole(USER)
    {
        _setPref (_toshare);
    }
}

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
    function get(address _customer, uint _index) public view returns (string memory text, bool purchased)
    {
        require(WishLists[_customer].isSharing);
        Item storage item = WishLists[_customer].items[_index];
        return (item.text, item.purchased);
    }

    //Later on make it a get list function.

} //End Wishlist




    // modifier isSharing(address _usderAdress){
    //     CustomerPreferences cp = CustomerPreferences(_contractAdress);
    //     cp.setX(_x);
    //     require (roles[_role][msg.sender], "not authorised");
    //     _;
    // }