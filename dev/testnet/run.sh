#!/bin/bash

../killbyname.sh "gaiacli rest-server"

./testnet.sh -i -s -n 4

#nohup gaiacli rest-server --node tcp://localhost:10157 &


for ((;;)) do
    tail -n 5 ./cache/gaiad.0.log
    tail -n 5 ./cache/gaiad.1.log
    tail -n 5 ./cache/gaiad.2.log
    tail -n 5 ./cache/gaiad.3.log
    sleep 5
done

