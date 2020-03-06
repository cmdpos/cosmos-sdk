#!/usr/bin/env bash

#./recover.sh

index=$1

valPubkey=$(gaiad tendermint show-validator --home cache/node${index}/gaiacli)

gaiacli tx staking create-validator --amount 2000000000neva \
    --pubkey ${valPubkey} \
    --chain-id testchain --commission-rate 0.1 \
    --commission-max-rate 0.5 \
    --commission-max-change-rate 0.001 \
    -b block \
    --min-self-delegation 1 --from node${index} --moniker node${index} -y --node localhost:10057 \
    --home cache/node${index}/gaiacli
