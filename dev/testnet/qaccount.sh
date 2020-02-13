#!/bin/bash


CUR_DIR=`pwd`

COSMOS_TOP=${GOPATH}/src/github.com/cmdpos/cmapp

CHAIN_NODE="--node tcp://localhost:10057"



loop_nodes() {
    for (( i=0; i<${1}; i++)) do
        if [ -d cache/node${i} ]; then
            echo "============================================================="
            echo "node${i} account details:"
            CHAIN_HOME="--home ${CUR_DIR}/cache/node${i}/gaiacli"
            CHAIN_ENV0="--node tcp://localhost:10057 --home "${CUR_DIR}"/cache/node${i}/gaiacli --chain-id testchain"

            delegater_address=$(gaiacli keys show node${i} -a ${CHAIN_HOME})
            operator_address=$(gaiacli keys show node${i} --bech val -a ${CHAIN_HOME})

            gaiacli query account $delegater_address ${CHAIN_ENV0}
            gaiacli query distr rewards $delegater_address ${CHAIN_ENV0}
            gaiacli query staking validator $operator_address ${CHAIN_ENV0}
        fi
    done
}


loop_nodes 10
