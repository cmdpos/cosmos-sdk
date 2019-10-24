#!/bin/bash

nodeid=1
CUR_DIR=`pwd`

COSMOS_TOP=${GOPATH}/src/github.com/cmdpos/cmapp
CLI_NAME=gaiacli

#CHAIN_ENV0="--node tcp://localhost:10057 --home "${CUR_DIR}"/cache/node${1}/gaiacli  --chain-id testchain"
CLI_HOME="--home ${CUR_DIR}/cache/node${nodeid}/gaiacli"
CHAIN_NODE="--node tcp://localhost:10${nodeid}57"

echo "=============query staking validators================="
${CLI_NAME} query staking validators ${CLI_HOME} --chain-id testchain
#${CHAIN_NODE}

for ((index=0; index<10; index++)) do
    if [ -d cache/node${index} ]; then
        echo "=============dump node${index} validator info================="
        echo "node-id:"
        gaiad tendermint show-node-id --home cache/node${index}/gaiad
        echo "Validator Consensus Pubkey:"
        gaiad tendermint show-validator --home cache/node${index}/gaiad
        echo "Validator address"
        gaiad tendermint show-address --home cache/node${index}/gaiad
        echo "Delegater address"
        gaiacli keys show node${index} -a --home cache/node${index}/gaiacli
        echo "Operator Address:"
        gaiacli keys show node${index} --bech val -a --home cache/node${index}/gaiacli
        echo "bech cons address:"
        gaiacli keys show node${index} --bech cons -a --home cache/node${index}/gaiacli
    fi
done


exit
gaiacli keys add --recover u1  << EOF
brain humor inform change try spawn region repeat obey orchard slab flag destroy perfect extra actress day short alien submit will imitate copy rack
EOF

exit
===== Generate testnet configurations files...====
gaiad testnet --v 4 -o cache --chain-id testchain --starting-ip-address 127.0.0.1 --base-port 10056
addr: [cmdpos13sj43lcryln0ez8zv33rnvy25rlgrg6pt6fmtg]
secret: [
brain humor inform change try spawn region repeat obey orchard slab flag destroy perfect extra actress day short alien submit will imitate copy rack]
addr: [cmdpos1evvxjcjkhg6f3juz0s984rc2xjcd4mkchj9f4c]
secret: [person output supply tuna mule return female inject cheap spy fetch sport palm float disagree behave paddle thought grunt prevent kitchen machine program quality]
addr: [cmdpos15edsnycr8ms454qna5wk5vv6v6u0w98h0mhdyu]
secret: [hat half turkey slogan lend fatigue census fade umbrella inquiry whale volcano inject hedgehog again dinner legal fragile sponsor ritual category alone express hen]
addr: [cmdpos1wurw9pa2xcyq8s5t3wr3afnp0256cs55fymmlv]
secret: [vast certain garage group congress whisper flush current sister puppy suggest opera math budget sword lift sister path icon polar hub crunch math kiwi]
Successfully initialized 4 node directories


