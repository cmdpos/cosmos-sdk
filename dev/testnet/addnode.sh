#!/usr/bin/env bash

source env.profile

while getopts "i:n:p:r:s:b:" opt; do
  case $opt in
    i)
      echo "IP=$OPTARG"
      IP=$OPTARG
      ;;
    n)
      echo "INPUT_INDEX=$OPTARG"
      INPUT_INDEX=$OPTARG
      ;;
    p)
      echo "INPUT_P2PPORT=$OPTARG"
      INPUT_P2PPORT=$OPTARG
      ;;
    r)
      echo "INPUT_RPCPORT=$OPTARG"
      INPUT_RPCPORT=$OPTARG
      ;;
    s)
      echo "INPUT_SEEDNODE=$OPTARG"
      INPUT_SEEDNODE=$OPTARG
      ;;
    b)
      echo "BIN_NAME=$OPTARG"
      BIN_NAME=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      ;;
  esac
done

function usage {
    echo "Invalid index!"
    echo "Use '-n' to specify the node id. Less then 99."
}

if [ -z "${INPUT_INDEX}" ]; then
    usage
    exit
fi

NODE_ID=node${INPUT_INDEX}
let p2p_port=${BASE_PORT_PREFIX}+${INPUT_INDEX}*100+${P2P_PORT_SUFFIX}
let rpc_port=${BASE_PORT_PREFIX}+${INPUT_INDEX}*100+${RPC_PORT_SUFFIX}
((rest_port = BASE_PORT_PREFIX + INPUT_INDEX * 100 + REST_PORT_SUFFIX))

# overwrite default ones
if [ ! -z ${INPUT_RPCPORT} ]; then
    rpc_port=${INPUT_RPCPORT}
fi

if [ ! -z ${INPUT_P2PPORT} ]; then
    p2p_port=${INPUT_P2PPORT}
fi

if [ -z ${IP} ]; then
    IP="127.0.0.1"
fi

if [ -d ${COSMOS_NET_CACHE}/node0/gaiad ]; then
    seed_addr=$(${COSMOS_BIN}/${BIN_NAME} tendermint show-node-id --home ${COSMOS_NET_CACHE}/node0/gaiad)@${IP}:${seedp2pport}
fi

if [ ! -z ${INPUT_SEEDNODE} ]; then
    seed_addr=${INPUT_SEEDNODE}
fi


function init {
    if [ ${INPUT_INDEX} -gt 99 ]; then
        usage
        exit
    fi

    if [ "${INPUT_INDEX}" -lt 1 ]; then
        usage
        exit
    fi

    if [ -d ${COSMOS_NET_CACHE}/${NODE_ID} ]; then
        echo "Invalid index!"
        echo "<${COSMOS_NET_CACHE}/${NODE_ID}> already exists. Use '-n' to try another index."
        echo "For example: ./addnewnode.sh -n 9 -s ${seed_addr}"
        exit
    fi

    if [ -z ${seed_addr} ]; then
        echo "Invalid seed node!"
        echo "Use '-s' to specify the seed node."
        echo "For example: ./addnewnode.sh -n 6 -s ${seed_addr}"
        exit
    fi

    ${COSMOS_BIN}/${BIN_NAME} init ${NODE_ID} -o --chain-id testchain --home ${COSMOS_NET_CACHE}/${NODE_ID}/gaiad
}


function start {
    echo "init new node..."
    init
    echo "init new node done"

#    exit
    echo "copy the genesis file..."
    rm ${COSMOS_NET_CACHE}/${NODE_ID}/gaiad/config/genesis.json
    cp ${COSMOS_NET_CACHE}/node0/gaiad/config/genesis.json ${COSMOS_NET_CACHE}/${NODE_ID}/gaiad/config/
    echo "copy the genesis file done"

    echo "start new node..."
    p2pport=$1
    rpcport=$2
    restport=$4
    seednode=$3

    echo "${BIN_NAME} --home ${COSMOS_NET_CACHE}/${NODE_ID}/gaiad  start --p2p.laddr tcp://${IP}:${p2pport} --p2p.seeds ${seednode} --rpc.laddr tcp://${IP}:${rpcport}"

    ${COSMOS_BIN}/${BIN_NAME} start\
    --home ${COSMOS_NET_CACHE}/${NODE_ID}/gaiad \
    --p2p.laddr tcp://${IP}:${p2pport} \
    --p2p.seeds ${seednode} \
    --p2p.addr_book_strict=false\
    --rest.laddr tcp://${IP}:${restport}\
    --rpc.laddr tcp://${IP}:${rpcport} > ${COSMOS_NET_CACHE}/${BIN_NAME}.${NODE_ID}.log 2>&1 &

    echo "start new node done"
}

start ${p2p_port} ${rpc_port} ${seed_addr} ${rest_port}
