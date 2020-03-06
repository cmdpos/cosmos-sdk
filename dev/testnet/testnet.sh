#!/usr/bin/env bash

NUM_NODE=1
source env.profile

while getopts "isn:b:p:" opt; do
  case $opt in
    i)
      echo "COSMOS_INIT"
      COSMOS_INIT=1
      ;;
    s)
      echo "COSMOS_START"
      COSMOS_START=1
      ;;
    n)
      echo "NUM_NODE=$OPTARG"
      NUM_NODE=$OPTARG
      ;;
    b)
      echo "BIN_NAME=$OPTARG"
      BIN_NAME=$OPTARG
      ;;
    p)
      echo "IP=$OPTARG"
      IP=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      ;;
  esac
done


function init {
    cd ${COSMOS_TOP}

    make install

    cd ${COSMOS_NET_TOP}
    ${COSMOS_TOP}/dev/killbyname.sh ${BIN_NAME}
    rm -rf ${COSMOS_NET_CACHE}

    echo "=================================================="
    echo "===== Generate testnet configurations files...===="
    echo "${BIN_NAME} testnet --v $1 -o cache --chain-id testchain --starting-ip-address ${IP} --base-port ${BASE_PORT}"
    ${COSMOS_BIN}/${BIN_NAME} testnet --v $1 -o cache \
    --chain-id testchain \
    --starting-ip-address ${IP} \
    --base-port ${BASE_PORT}  <<EOF
EOF
}

function start {
    ${COSMOS_TOP}/dev/killbyname.sh ${BIN_NAME}

    index=0

    echo "============================================"
    echo "=========== Startup seed node...============"
    echo "${BIN_NAME} --home ${COSMOS_NET_CACHE}/node${index}/gaiad  start --p2p.laddr tcp://${IP}:${seedp2pport} --p2p.seed_mode=true --p2p.addr_book_strict=false  --rpc.laddr tcp://${IP}:${seedrpcport}"
    nohup ${COSMOS_BIN}/${BIN_NAME} start \
    --home ${COSMOS_NET_CACHE}/node${index}/${BIN_NAME} \
    --p2p.laddr tcp://${IP}:${seedp2pport} \
    --p2p.seed_mode=true --p2p.addr_book_strict=false \
    --log_level "main:info,state:info,*:error" \
    --rest.laddr tcp://${IP}:${seedrestport} \
    --rpc.laddr tcp://${IP}:${seedrpcport} > ${COSMOS_NET_CACHE}/${BIN_NAME}.${index}.log 2>&1 &

    seed=$(${COSMOS_BIN}/${BIN_NAME} tendermint show-node-id --home ${COSMOS_NET_CACHE}/node${index}/${BIN_NAME})



    echo "============================================"
    echo "======== Startup validator nodes...========="
    for ((index=1; index<${1}; index++)) do

        let p2pport=${BASE_PORT_PREFIX}+${index}*100+${P2P_PORT_SUFFIX}
        let rpcport=${BASE_PORT_PREFIX}+${index}*100+${RPC_PORT_SUFFIX}

        ((restport = BASE_PORT_PREFIX + index * 100 + REST_PORT_SUFFIX))

        echo "${BIN_NAME} --home ${COSMOS_NET_CACHE}/node${index}/gaiad  start --p2p.laddr tcp://${IP}:${p2pport} --p2p.seeds ${seed}@${IP}:${seedp2pport} --p2p.addr_book_strict=false  --rpc.laddr tcp://${IP}:${rpcport}"

        nohup ${COSMOS_BIN}/${BIN_NAME} start \
        --home ${COSMOS_NET_CACHE}/node${index}/${BIN_NAME} \
        --p2p.laddr tcp://${IP}:${p2pport} \
        --p2p.seeds ${seed}@${IP}:${seedp2pport} \
        --log_level "main:info,state:info,*:error" \
        --p2p.addr_book_strict=false \
        --rest.laddr tcp://${IP}:${restport} \
        --rpc.laddr tcp://${IP}:${rpcport} > ${COSMOS_NET_CACHE}/${BIN_NAME}.${index}.log 2>&1 &
    done
    echo "start node done"
}

if [ -z ${IP} ]; then
    IP="127.0.0.1"
fi

if [ ! -z "${COSMOS_INIT}" ]; then
    init ${NUM_NODE}
fi

if [ ! -z "${COSMOS_START}" ]; then
    start ${NUM_NODE}
fi



