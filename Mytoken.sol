// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract mod3 {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    
    address public owner;
    
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
    
    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _initialSupply) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply * 50**uint256(_decimals);
        balanceOf[msg.sender] = totalSupply;
        owner = msg.sender;
    }
    
    function transfer(address _to, uint256 _value) external returns (bool) {
        
        require(_value <= balanceOf[msg.sender], "Insufficient balance");
        
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        
        return true;
    }
    
    function approve(address _spender, uint256 _value) external returns (bool) {
        
        allowance[msg.sender][_spender] = _value;
        
        return true;
    }
    
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool) {
        
        require(_value <= balanceOf[_from], "Insufficient balance");
        require(_value <= allowance[_from][msg.sender], "Insufficient allowance");
        
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        
        return true;
    }
    
    function mint(address _to, uint256 _value) external onlyOwner returns (bool) {
        
        balanceOf[_to] += _value;
        totalSupply += _value;
       
        return true;
    }
    
    function burn(uint256 _value) external returns (bool) {
        require(_value <= balanceOf[msg.sender], "Insufficient balance");
        
        balanceOf[msg.sender] -= _value;
        totalSupply -= _value;
        
        
        return true;
    }
}
