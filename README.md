# Crypto Melo

Crypto Melo é uma criptomoeda baseada na Rede Ethereum implementada conforme o padrão ERC-20.

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

<img src="https://github.com/user-attachments/assets/aff3f13d-3523-4f22-a3d9-180904da9508" alt="Truffle"/>


## Contrato

Aqui está o código do contrato `CryptoMelo.sol`:

<img src="https://github.com/user-attachments/assets/1569839f-0828-4288-a990-9a4a1417f65c" alt="CryptoMelo"/>

## Contribuição

Se você deseja contribuir com o projeto, sinta-se à vontade para abrir um pull request ou relatar problemas no [GitHub Issues](https://github.com/caio-videmelo/dcriptomoeda-rede-ethereum/issues).
