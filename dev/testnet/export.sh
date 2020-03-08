#!/usr/bin/env bash


index=0

/killbyname.sh gaiad
35gaiad export --for-zero-height  --home cache/node${index}/gaiad > 36.json

37gaiad migrate v0.36 36.json | jq > 37.json

rm -rf 37cache
cp -rf cache 37cache
35gaiad unsafe-reset-all --home 37cache/node0/gaiad
35gaiad unsafe-reset-all --home 37cache/node1/gaiad
35gaiad unsafe-reset-all --home 37cache/node2/gaiad
35gaiad unsafe-reset-all --home 37cache/node3/gaiad

cp 37.json 37cache/node0/gaiad/config/genesis.json
cp 37.json 37cache/node1/gaiad/config/genesis.json
cp 37.json 37cache/node2/gaiad/config/genesis.json
cp 37.json 37cache/node3/gaiad/config/genesis.json

./37testnet.sh -i -s -n 4
