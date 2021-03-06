// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract AccessControl {
    // Eents
    event GrantRole(bytes32 indexed role, address indexed account);
    event RevokeRole(bytes32 indexed role, address indexed account);
    
    // role => account => bool
    mapping(bytes32 => mapping ( address => bool) ) public roles;
    // we save gas by mapping the name to numbers
    
    // define roles, Note that other roles can be made
    

    // 0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 public constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    // 0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
    bytes32 public constant USER = keccak256(abi.encodePacked("USER"));

       
    modifier onlyRole(bytes32 _role){
        require (roles[_role][msg.sender], "not authorised");
        _;
    }

    constructor() {
        _grantRole(ADMIN, msg.sender);
    }


    // public - all can access
    // external - Cannot be accessed internally, only externally
    // internal - only this contract and contracts deriving from it can access
    // private - can be accessed only from this contract

    function _grantRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = true;
        emit GrantRole(_role, _account);
    }

    function grantRole(bytes32 _role, address _account) external  onlyRole(ADMIN){
        _grantRole (_role,_account);
    }

    function revokeRole(bytes32 _role, address _account) external  onlyRole(ADMIN){
        roles[_role][_account] = false;
        emit RevokeRole(_role, _account);   
    }

    //  prefNum = 0 means not approoving of sharing details
    // uint8 public prefNum = 0 ;
    //  prefNum = 1 means not approoving of sharing details
    // uint8 public prefNum1 = 1 ;
}