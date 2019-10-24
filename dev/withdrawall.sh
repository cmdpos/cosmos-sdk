#!/usr/bin/env bash




#gaiacli query account cosmos1hg40dv5e237qy28vtyum52ygke32ez35hm307h
#
#
#gaiacli query staking validators
#
#gaiacli tx distr withdraw-all-rewards --from 307 -y -b block
#
#gaiacli query account cosmos1hg40dv5e237qy28vtyum52ygke32ez35hm307h
#
#
#gaiacli tx distr withdraw-rewards cosmosvaloper1hg40dv5e237qy28vtyum52ygke32ez35j096jy --from 307  -y -b block
gaiacli tx distr withdraw-rewards cosmosvaloper1hg40dv5e237qy28vtyum52ygke32ez35j096jy --from 307 --commission -y --fees 2stake -b block

