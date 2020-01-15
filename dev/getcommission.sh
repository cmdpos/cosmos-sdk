#!/usr/bin/env bash
##############################################################
## 输入参数

# 取样时间(秒)
DURATION=6

# 超级节点 operator 地址
VALIDATOR=evavaloper1wgp2hm4fvptsu7zhsxg6wpshz9udg4ysh4hfd7

##############################################################

TEMP=_temp_delegator_address
EVA_VALIDATOR_URL=http://18.163.89.47:20181
START=$(date)

gaiacli query staking delegations-to ${VALIDATOR} --node http://18.163.89.47:20181 | grep delegator_address > $TEMP
sed -i '' 's/    "delegator_address": "//g' $TEMP
sed -i '' 's/",//g' $TEMP

DELEGATOR_ARRAY=($(awk '{print $1}' $TEMP))

queryRewards() {
    res=$(gaiacli query distr rewards $1 $2 --node $EVA_VALIDATOR_URL -o text)
    a=${res/neva/}
    string="$a"
    array=(${string//./ })
    echo ${array[0]}
}

queryCommission() {
    res=$(gaiacli query distr commission $1 --node $EVA_VALIDATOR_URL -o text)
    a=${res/neva/}
    string="$a"
    array=(${string//./ })
    echo ${array[0]}
}

sum() {
    sum=0
    for delegator in ${DELEGATOR_ARRAY[@]}
    do
        rewards=$(queryRewards $delegator $VALIDATOR)
       ((sum=sum+rewards))
    done
    echo $sum
}

main() {

    sumRewards1=$(sum)
    commission1=$(queryCommission $VALIDATOR)

    sleep $DURATION

    sumRewards2=$(sum)
    commission2=$(queryCommission $VALIDATOR)

    ((commissionDelta=commission2-commission1))
    ((rewardsDelta=sumRewards2-sumRewards1))
    ((allDelta=sumRewards2-sumRewards1+commissionDelta))

    echo "["$START -- `date`"]期间, 超级节点["${VALIDATOR}"]挖矿奖励分配: "
    echo "1. 所有在该超级节点上质押token的delegator奖励总和: "$rewardsDelta
    echo "2. 该超级节点的delegator个数: "${#DELEGATOR_ARRAY[@]}
    echo "3. 该超级节点佣金: "$commissionDelta

    commissionDelta=$[commissionDelta*100]
    echo "4. 计算得出该超级节点["${VALIDATOR}"] commission rate: "$((commissionDelta/allDelta))% "= $commissionDelta / ($rewardsDelta + $commissionDelta)"
}

main