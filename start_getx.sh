#!/bin/bash
WALLET="0x9dbe1caae874baae91022d170fba246100c73286"
screen -S getx ./getx --rpc --maxpeers 75 --syncmode "fast" --rpcapi "net,web3,personal" --etherbase "$WALLET" --cache=12288 --mine --unlock "$WALLET" --allow-insecure-unlock --password ~/pwd &
