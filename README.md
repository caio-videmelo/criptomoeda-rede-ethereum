# DIO Token

DIO Token é uma criptomoeda baseada na Rede Ethereum implementada conforme o padrão ERC-20.

## Sumário

- [Introdução](#introdução)
- [Requisitos](#requisitos)
- [Instalação](#instalação)
- [Como Usar](#como-usar)
- [Contrato](#contrato)
- [Contribuição](#contribuição)
- [Licença](#licença)

## Introdução

O DIO Token é um exemplo de implementação de uma criptomoeda simples utilizando o padrão ERC-20 na blockchain do Ethereum. Este projeto serve como uma base para entender a criação de tokens e explorar mais funcionalidades do Ethereum.

## Requisitos

- [Node.js](https://nodejs.org/)
- [npm](https://www.npmjs.com/)
- [Truffle](https://www.trufflesuite.com/truffle)
- [Ganache](https://www.trufflesuite.com/ganache) (opcional, para ambiente de desenvolvimento local)
- [Metamask](https://metamask.io/) (ou outra carteira Ethereum)

## Instalação

1. Clone o repositório:
   ```sh
   git clone https://github.com/mario-evangelista/criptomoeda-rede-ethereum.git
   cd dio-token
   ```

2. Instale as dependências:
   ```sh
   npm install
   ```

3. Compile os contratos:
   ```sh
   truffle compile
   ```

4. Faça o deploy dos contratos (no Ganache ou em outra rede Ethereum):
   ```sh
   truffle migrate
   ```

## Como Usar

Após a instalação e deploy, você pode interagir com o contrato utilizando Truffle Console:

```sh
truffle console
```

Dentro do console Truffle, você pode executar comandos como:

```js
let instance = await DIOToken.deployed();
let accounts = await web3.eth.getAccounts();
await instance.balanceOf(accounts[0]);
await instance.transfer(accounts[1], web3.utils.toWei('1', 'ether'));
await instance.approve(accounts[2], web3.utils.toWei('0.5', 'ether'));
await instance.allowance(accounts[0], accounts[2]);
await instance.transferFrom(accounts[0], accounts[2], web3.utils.toWei('0.5', 'ether'), { from: accounts[2] });
```

## Contrato

Aqui está o código do contrato `DIOToken.sol`:

```solidity
pragma solidity ^0.8.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
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

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(recipient != address(0), "Transfer to the zero address");
        require(amount <= _balances[msg.sender], "Insufficient balance");

        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        require(spender != address(0), "Approve to the zero address");

        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        require(sender != address(0), "Transfer from the zero address");
        require(recipient != address(0), "Transfer to the zero address");
        require(amount <= _balances[sender], "Insufficient balance");
        require(amount <= _allowances[sender][msg.sender], "Allowance exceeded");

        _balances[sender] -= amount;
        _allowances[sender][msg.sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }
}
```

## Contribuição

Se você deseja contribuir com o projeto, sinta-se à vontade para abrir um pull request ou relatar problemas no [GitHub Issues](https://github.com/seu-usuario/dio-token/issues).

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).
```
