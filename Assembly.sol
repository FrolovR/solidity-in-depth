pragma solidity ^0.4.20;

contract Assembly {

    function Bytes1() external pure returns(bytes1 input) {
        bytes memory b = hex"FF";

        assembly {
             input := mload(add(b, 32))
        }
    }

    function Uint8() external pure returns(uint8 input) {
        bytes memory b = hex"FF";

        assembly {
             input := mload(add(b, 32))
        }
    }

    function foo() public {
        bytes32 a = 0xff000000000000000000000000000000000000000000000000000000000000BB;
        uint8 b = uint8(a);
        bytes1 c = bytes1(a);
        require(b == 0xBB);
        require(c == 0xFF);
        log3("hello!", bytes32(a), bytes32(b), bytes32(c));
    }
}
