pragma solidity ^0.8.0;

interface IERC20 {
    // Getters
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    // Functions
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    // Events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

contract DIOToken is IERC20 {
    string public constant name = "DIO Token";
    string public constant symbol = "DIO";
    uint8 public constant decimals = 18;
    uint256 private _totalSupply = 10 ether;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    constructor() {
        _balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function transfer(
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        require(recipient != address(0), "Transfer to the zero address");
        require(amount <= _balances[msg.sender], "Insufficient balance");

        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(
        address spender,
        uint256 amount
    ) public override returns (bool) {
        require(spender != address(0), "Approve to the zero address");

        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function allowance(
        address owner,
        address spender
    ) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        require(sender != address(0), "Transfer from the zero address");
        require(recipient != address(0), "Transfer to the zero address");
        require(amount <= _balances[sender], "Insufficient balance");
        require(
            amount <= _allowances[sender][msg.sender],
            "Allowance exceeded"
        );

        _balances[sender] -= amount;
        _allowances[sender][msg.sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }
}
