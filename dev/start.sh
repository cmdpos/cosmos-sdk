#!/usr/bin/env bash

/killbyname.sh gaiad
/killbyname.sh "gaiacli rest-server"

rm nohup.out

(cd .. && make install)

rm -rf cache

gaiad testnet --v 1 --output-dir cache --chain-id testchain --starting-ip-address 127.0.0.1<<EOF
12345678
EOF

gaiacli config chain-id testchain
gaiacli config trust-node true
gaiacli config output json
gaiacli config indent true

sleep 1
nohup gaiacli rest-server &
gaiad start --home cache/node0/gaiad

