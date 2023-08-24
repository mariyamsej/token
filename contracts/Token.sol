// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC20.sol";
import "./Pausable.sol";
import "./AccessControl.sol";

contract H2KToken is ERC20, Pausable, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    constructor() ERC20("H2K Token", "CH2K") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    // function decimals() public pure override returns (uint8) {
    //     return 6;
    // }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }

    modifier onlyAdmin() {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Caller is not the admin");
        _;
    }

    receive() external payable onlyAdmin {
        // uint256 tokenAmount = msg.value * 100;
        _mint(msg.sender, msg.value);
    }

    fallback() external payable onlyAdmin {
        // uint256 tokenAmount = msg.value * 100;
        _mint(msg.sender, msg.value);
    }
    
}