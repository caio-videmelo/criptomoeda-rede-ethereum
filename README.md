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

O Crypto Melo é um exemplo de implementação de uma criptomoeda simples utilizando o padrão ERC-20 na blockchain do Ethereum. Este projeto serve como uma base para entender a criação de tokens e explorar mais funcionalidades do Ethereum.

## Requisitos

- [Node.js](https://nodejs.org/)
- [npm](https://www.npmjs.com/)
- [Truffle](https://www.trufflesuite.com/truffle)
- [Ganache](https://www.trufflesuite.com/ganache) (opcional, para ambiente de desenvolvimento local)
- [Metamask](https://metamask.io/) (ou outra carteira Ethereum)

## Instalação

1. Clone o repositório:
   ```sh
   git clone https://github.com/caio-videmelo/criptomoeda-rede-ethereum.git
   cd CryptoMelo
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

Aqui está o código do contrato `CryptoMelo.sol`:

```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface IERC20{

    //getters
    function totalSupply() external view returns(uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);

    //functions
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256);

}

contract CryptoMelo is IERC20{

    string public constant name = "Crypto Melo";
    string public constant symbol = "Melo";
    uint8 public constant decimals = 18;

    mapping (address => uint256) balances;

    mapping(address => mapping(address=>uint256)) allowed;

    uint256 totalSupply_ = 10 ether;

    constructor(){
        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public override view returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address tokenOwner) public override view returns (uint256){
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender]-numTokens;
        balances[receiver] = balances[receiver]+numTokens;
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

    function approve(address delegate, uint256 numTokens) public override returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function allowance(address owner, address delegate) public override view returns (uint) {
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[owner]);
        require(numTokens <= allowed[owner][msg.sender]);

        balances[owner] = balances[owner]-numTokens;
        allowed[owner][msg.sender] = allowed[owner][msg.sender]-numTokens;
        balances[buyer] = balances[buyer]+numTokens;
        emit Transfer(owner, buyer, numTokens);
        return true;
    }

}
```

## Contribuição

Se você deseja contribuir com o projeto, sinta-se à vontade para abrir um pull request ou relatar problemas no [GitHub Issues](https://github.com/caio-videmelo/dcriptomoeda-rede-ethereum/issues).
