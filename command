anvil --fork-url https://polygon-mainnet.infura.io/v3/0a83511d777c4ff5aa428059087e7794 --fork-block-number 50675593

forge script --broadcast script/StakeAndUnstake.s.sol:ContractScript --fork-url http://localhost:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

forge test -vvv --fork-url http://localhost:8545
