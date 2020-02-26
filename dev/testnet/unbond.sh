#!/usr/bin/env bash

NODE_ENV="--node tcp://localhost:10057"

unbond(){

    gaiacli tx staking unbond $1 100000000000eva --from $2 --node tcp://localhost:10157 --chain-id testchain

}


unbond $1 $2