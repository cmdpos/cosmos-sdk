#!/usr/bin/env bash


#gaiacli tx staking unbond cosmosvaloper1ru8xdlfwhdskkn4h87v5mxuvaddnse9wpsxp9z 1stake --from 307 --fees 2stake -yes -b block <<EOF

#gaiacli tx staking redelegate [src-validator-addr] [dst-validator-addr] [amount] [flags]

gaiacli tx staking delegate cosmosvaloper1y5cj26cexle8mrpxfksnly2djzxx79zq2mf083 10000stake --from 307 --fees 2stake -yes -b block <<EOF
12345678
EOF

gaiacli query account cosmos1hg40dv5e237qy28vtyum52ygke32ez35hm307h


gaiacli query staking validators

# oakmac:dev oak$ gaiacli tx distr withdraw-all-rewards --from 307 -y -b block
#6000000008344905
#
#6000000009303469

# 6000000011260675


##local
gaiacli tx staking delegate evavaloper1hg40dv5e237qy28vtyum52ygke32ez35xexq98 380000000000stake --from v0 --fees 2stake -yes -b block


