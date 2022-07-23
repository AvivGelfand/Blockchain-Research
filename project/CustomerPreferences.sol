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


    // 0x57e249ee06eaace1940d50c53f83a2379596ee56f575e7b2da5612906fb1b610 // private
    // bytes32 private constant SHOW = keccak256(abi.encodePacked("SHOW")); // should not be constant
    // 0xef59a5c75ef68c471c8ccfd3cb4466e331a6f232248a5885e29e15acc105f885 // private
    // bytes32 private constant HIDE = keccak256(abi.encodePacked("HIDE")); // should not be constant

    bool private ShareWishList = false;
    
     // USER setting HIDE / SHOW:
    function _setPref(bool _toshare) internal {
        emit SetShare(_toshare, msg.sender);
    }

    function setPref(bool _toshare) external  onlyRole(USER)
    {
        _setPref (_toshare);
    }
    
    // 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db

    // NOW SET FOR GRANTED SHARE TO GET DETAILS OF WISH LIST


    // Transaction HASHES COULD BE THE DATA!
}