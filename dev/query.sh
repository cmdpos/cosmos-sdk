#!/usr/bin/env bash


gaiacli query account cosmos1hg40dv5e237qy28vtyum52ygke32ez35hm307h --chain-id testchain --node localhost:26657
gaiacli query account cosmos1geyy4wtak2q9effnfhze9u4htd8yxxmagdw3q0 --chain-id testchain --node localhost:26657


curl http://localhost:1317/auth/accounts/cosmos1hg40dv5e237qy28vtyum52ygke32ez35hm307h
curl http://localhost:1317/auth/accounts/cosmos1geyy4wtak2q9effnfhze9u4htd8yxxmagdw3q0


gaiacli query staking validators

# vf
# eva1qnkgg9h04v4avc79lzqj9tgdztzlw4e8454mvm
# evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3

# my addr
# eva1fsvvrkwvlh7084mwlpjek4vjm04enljejpl7z4
gaiacli query distr rewards eva1qnkgg9h04v4avc79lzqj9tgdztzlw4e8454mvm evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181
gaiacli query distr rewards eva1qnkgg9h04v4avc79lzqj9tgdztzlw4e8454mvm  --node http://18.163.89.47:20181
gaiacli query distr rewards eva1fsvvrkwvlh7084mwlpjek4vjm04enljejpl7z4 evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181
gaiacli query distr rewards eva1fsvvrkwvlh7084mwlpjek4vjm04enljejpl7z4  --node http://18.163.89.47:20181
gaiacli query distr commission  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181
gaiacli query distr community-pool   --node http://18.163.89.47:20181

gaiacli query staking delegations-to evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181

community-pool

gaiacli query account eva1fsvvrkwvlh7084mwlpjek4vjm04enljejpl7z4 --node http://18.163.89.47:20181

#######################################3
gaiacli query staking validators  --node http://18.163.89.47:20181
gaiacli query staking pool  --node http://18.163.89.47:20181
gaiacli query staking params  --node http://18.163.89.47:20181


## 伊娃
## eva132q0hvhfjx84wl04ez9urnvqs3f7futq48atsw
## evavaloper132q0hvhfjx84wl04ez9urnvqs3f7futqr6la5t
gaiacli query staking delegations eva1fsvvrkwvlh7084mwlpjek4vjm04enljejpl7z4  --node http://18.163.89.47:20181


gaiacli query account eva132q0hvhfjx84wl04ez9urnvqs3f7futq48atsw --node http://18.163.89.47:20181

gaiacli query staking delegations-to evavaloper132q0hvhfjx84wl04ez9urnvqs3f7futqr6la5t --node http://18.163.89.47:20181


gaiacli query staking delegation eva1qpfqusq9atcmag6nmjhh8age3jaznw0nwrjg5j evavaloper132q0hvhfjx84wl04ez9urnvqs3f7futqr6la5t --node http://18.163.89.47:20181



gaiacli query distr rewards eva1qpfqusq9atcmag6nmjhh8age3jaznw0nwrjg5j evavaloper132q0hvhfjx84wl04ez9urnvqs3f7futqr6la5t --node http://18.163.89.47:20181











