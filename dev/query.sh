#!/usr/bin/env bash


a=xxneva
echo ${a/neva/}

exit


queryRewards() {
    res=$(gaiacli query distr rewards $1 $2 --node http://18.163.89.47:20181 -o text)
    echo ${res/neva/}
}

gaiacli query distr commission  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181

########

gaiacli query account cosmos1hg40dv5e237qy28vtyum52ygke32ez35hm307h --chain-id testchain --node localhost:26657
gaiacli query account cosmos1geyy4wtak2q9effnfhze9u4htd8yxxmagdw3q0 --chain-id testchain --node localhost:26657


curl http://localhost:1317/auth/accounts/cosmos1hg40dv5e237qy28vtyum52ygke32ez35hm307h
curl http://localhost:1317/auth/accounts/cosmos1geyy4wtak2q9effnfhze9u4htd8yxxmagdw3q0


gaiacli query staking validators --node http://18.163.89.47:20181

# vf
# eva1qnkgg9h04v4avc79lzqj9tgdztzlw4e8454mvm
# evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3

# my addr
# eva1fsvvrkwvlh7084mwlpjek4vjm04enljejpl7z4
gaiacli query distr rewards eva1qnkgg9h04v4avc79lzqj9tgdztzlw4e8454mvm evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181
gaiacli query distr rewards eva1qnkgg9h04v4avc79lzqj9tgdztzlw4e8454mvm  --node http://18.163.89.47:20181
gaiacli query distr rewards eva1fsvvrkwvlh7084mwlpjek4vjm04enljejpl7z4 evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181
gaiacli query distr rewards eva1fsvvrkwvlh7084mwlpjek4vjm04enljejpl7z4  --node http://18.163.89.47:20181
gaiacli query distr commission  evavaloper18dq7anelgyaw7t9dn52249kq57js203tp9q07c --node http://18.163.89.47:20181
gaiacli query distr community-pool   --node http://18.163.89.47:20181

gaiacli query staking delegations-to evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181
gaiacli query staking delegations-to evavaloper1wgp2hm4fvptsu7zhsxg6wpshz9udg4ysh4hfd7 --node http://18.163.89.47:20181
gaiacli query staking delegations-to evavaloper18dq7anelgyaw7t9dn52249kq57js203tp9q07c --node http://18.163.89.47:20181
gaiacli query distr commission  evavaloper18dq7anelgyaw7t9dn52249kq57js203tp9q07c --node http://18.163.89.47:20181
gaiacli query staking validator evavaloper18dq7anelgyaw7t9dn52249kq57js203tp9q07c  --node http://18.163.89.47:20181


community-pool

gaiacli query account eva1fsvvrkwvlh7084mwlpjek4vjm04enljejpl7z4 --node http://18.163.89.47:20181
gaiacli query account eva1fsvvrkwvlh7084mwlpjek4vjm04enljejpl7z4 --node http://34.216.217.204:20181

#######################################3
gaiacli query staking validators  --node http://18.163.89.47:20181
gaiacli query staking pool  --node http://18.163.89.47:20181
gaiacli query staking params  --node http://18.163.89.47:20181

evavaloper13gwspcs5egjzzvtljtmxrcaey72d7fnuxq387n
evavaloper18dq7anelgyaw7t9dn52249kq57js203tp9q07c
## 伊娃
## eva132q0hvhfjx84wl04ez9urnvqs3f7futq48atsw
## evavaloper132q0hvhfjx84wl04ez9urnvqs3f7futqr6la5t

gaiacli query staking delegation eva132q0hvhfjx84wl04ez9urnvqs3f7futq48atsw evavaloper132q0hvhfjx84wl04ez9urnvqs3f7futqr6la5t --node http://18.163.89.47:20181

gaiacli query staking delegations eva1fsvvrkwvlh7084mwlpjek4vjm04enljejpl7z4  --node http://18.163.89.47:20181
gaiacli query staking validator eva1fsvvrkwvlh7084mwlpjek4vjm04enljejpl7z4  --node http://18.163.89.47:20181

gaiacli query account eva132q0hvhfjx84wl04ez9urnvqs3f7futq48atsw --node http://18.163.89.47:20181

gaiacli query staking delegations-to evavaloper132q0hvhfjx84wl04ez9urnvqs3f7futqr6la5t --node http://18.163.89.47:20181


gaiacli query staking delegation eva1qpfqusq9atcmag6nmjhh8age3jaznw0nwrjg5j evavaloper132q0hvhfjx84wl04ez9urnvqs3f7futqr6la5t --node http://18.163.89.47:20181



gaiacli query distr rewards eva1qpfqusq9atcmag6nmjhh8age3jaznw0nwrjg5j evavaloper132q0hvhfjx84wl04ez9urnvqs3f7futqr6la5t --node http://18.163.89.47:20181


gaiacli query staking delegation eva1hryyxy3m6hxwmdqzg7r260lm704ua8engerd9h evavaloper132q0hvhfjx84wl04ez9urnvqs3f7futqr6la5t --node http://18.163.89.47:20181


gaiacli query account eva1hryyxy3m6hxwmdqzg7r260lm704ua8engerd9h --node http://18.163.89.47:20181








gaiacli query distr rewards eva1qnkgg9h04v4avc79lzqj9tgdztzlw4e8454mvm  --node http://18.163.89.47:20181
gaiacli query distr rewards eva1pjx74f0l6nvwx857e8m5x78fepph4rrexq5dh5  --node http://18.163.89.47:20181
gaiacli query distr rewards eva19qv9zx0a0p2l02kcfrndv6k99wknadu04twzmv  --node http://18.163.89.47:20181
gaiacli query distr rewards eva19gcs0mp6fsusnmuxzsjrza97srfzv3mu5kdn5x  --node http://18.163.89.47:20181
gaiacli query distr rewards eva18h38cm2eap4k5jxetwwk4yq5zjze3wfsmlxpc4  --node http://18.163.89.47:20181
gaiacli query distr rewards eva1fsvvrkwvlh7084mwlpjek4vjm04enljejpl7z4  --node http://18.163.89.47:20181
gaiacli query distr rewards eva1dukare522acjd0up8ll3tpeh7rdt35q7jlu2r6  --node http://18.163.89.47:20181
gaiacli query distr rewards eva10kclpxhy9mxavdvyg3k20x9jfqqn7rlkyxz500  --node http://18.163.89.47:20181
gaiacli query distr rewards eva10hs433nww8pv5ru0r4x3xrm64xgwqgavdf6yxe  --node http://18.163.89.47:20181
gaiacli query distr rewards eva136ytju4l3twf2jjxgd7etr8527m5q9acp89glw  --node http://18.163.89.47:20181
gaiacli query distr rewards eva1jqr46kdxsnk7h8tnkh96e5uglvalxxawye5k8j  --node http://18.163.89.47:20181
gaiacli query distr rewards eva1j969dh9klyx43ej8s5rrd0j7xa95ym7ncxepa0  --node http://18.163.89.47:20181
gaiacli query distr rewards eva14pevscmc7lvnkmkfutp09wcn0ecgaldxsna03m  --node http://18.163.89.47:20181
gaiacli query distr rewards eva1ht5rs8d3sgy9882yrvcd79phskc70q2affm8nj  --node http://18.163.89.47:20181
gaiacli query distr rewards eva1he7hvqaycmgw0h3x56tku8jye5tj683z88tyax  --node http://18.163.89.47:20181
gaiacli query distr rewards eva1c8sfzqhtatquq07fxn2fj4vt6qzarmnkg4xr9h  --node http://18.163.89.47:20181
gaiacli query distr rewards eva1c3yhug3ztfkujq6unktdk9h9nmduk7fzackq00  --node http://18.163.89.47:20181
gaiacli query distr rewards eva16ttau6apv0fvh0m8e0tk2drkdvfaxlapt4mvdh  --node http://18.163.89.47:20181
gaiacli query distr rewards eva167qjyr23fcm50ptwpupa67v8ef5jk7keuap5fu  --node http://18.163.89.47:20181
gaiacli query distr rewards eva1uyvqg0z59st95x9hy4tde037r2x6tqev4f2w5k  --node http://18.163.89.47:20181
gaiacli query distr rewards eva1uxy3cldwdyxhzmauh4tdjg0uyfdrqcmr0mdf9t  --node http://18.163.89.47:20181
gaiacli query distr rewards eva17w56q0yzuvf42z9k0zrlrvlezect2jvxuauset  --node http://18.163.89.47:20181
