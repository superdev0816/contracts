// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts@4.8.0/utils/Context.sol";
import "@openzeppelin/contracts@4.8.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.8.0/token/ERC20/IERC20.sol";

contract Presale {
    address private admin;
    address private _BYD;
    address private _usdt;
    uint256 private amount;
    uint256 private start;
    uint256 private end;

    uint256 private tempAmount;
    mapping(address => uint256) balance;

    constructor(address USDT, address BYD) {
        admin = msg.sender;
        amount = 10000 ether;
        start = 0;
        end = 0;
        tempAmount = 0;
        _usdt = USDT;
        _BYD = BYD;
    }

    modifier onlyAdmin {
        require(admin == msg.sender, "admin required");
        _;
    }

    function setStart() public onlyAdmin {
        start = block.timestamp;
        end = start + 5 hours;
    }

    function withdraw() public onlyAdmin {
        uint total = IERC20(_usdt).balanceOf(address(this));
        IERC20(_usdt).transfer(msg.sender, total);
    }
    
    function sale() public {
        if (block.timestamp > start && block.timestamp < end && tempAmount < amount) {
            IERC20(_usdt).transferFrom(msg.sender, address(this), 10 ether);
            IERC20(_BYD).transfer(msg.sender, 10 ether);
            tempAmount += 10 ether;
        }
    }
}