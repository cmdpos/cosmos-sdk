#!/usr/bin/env bash
##############################################################

CLIENT_NAME=gaiacli

# eva网络入口
EVA_VALIDATOR_URL=http://18.163.89.47:20181
##############################################################

START=$(date)

queryRewards() {
    res=$(${CLIENT_NAME} query distr rewards $1 $2 --node $EVA_VALIDATOR_URL -o text)
    array=(${res//./ })
    echo ${array[0]}
}

queryCommission() {
    res=$(${CLIENT_NAME} query distr commission $1 --node $EVA_VALIDATOR_URL -o text)
    array=(${res//./ })
    echo ${array[0]}
}

sum() {
    sum=0
    DELEGATOR_ARRAY=$1
    for delegator in ${DELEGATOR_ARRAY[@]}
    do
        rewards=$(queryRewards $delegator $VALIDATOR)
       ((sum=sum+rewards))
    done
    echo $sum
}

#    run evavaloper18dq7anelgyaw7t9dn52249kq57js203tp9q07c $SAMPLE_DURATION
#    run evavaloper1wgp2hm4fvptsu7zhsxg6wpshz9udg4ysh4hfd7 $SAMPLE_DURATION
#    run evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 $SAMPLE_DURATION
#    run evavaloper18dq7anelgyaw7t9dn52249kq57js203tp9q07c $SAMPLE_DURATION
#    run evavaloper18a3dgc0z8vxpx8h9kknkd9tfp2aet9p4kkrcyn $SAMPLE_DURATION
#    run evavaloper1gu3sy9hd62lag5jj407q4rmhn4xcsuy7ryhg9l $SAMPLE_DURATION
#    run evavaloper1tgzaxfrs4vq6g2622xgxdxh0dyc7fuew6mxa28 $SAMPLE_DURATION
#    run evavaloper1dtt206qdvzpfktlu9asyjvltxea4nqtenkn6w9 $SAMPLE_DURATION
#    run evavaloper1wgp2hm4fvptsu7zhsxg6wpshz9udg4ysh4hfd7 $SAMPLE_DURATION
#    run evavaloper1w5h0hczucg4l90l6x7svzhdvv7me4z5sqfrqnq $SAMPLE_DURATION
#    run evavaloper1syd7sa4k2005t99ya4ggtffwcxlf93xp0rdc5m $SAMPLE_DURATION
#    run evavaloper13gwspcs5egjzzvtljtmxrcaey72d7fnuxq387n $SAMPLE_DURATION
#    run evavaloper132q0hvhfjx84wl04ez9urnvqs3f7futqr6la5t $SAMPLE_DURATION
#    run evavaloper1hryyxy3m6hxwmdqzg7r260lm704ua8en7ypmpj $SAMPLE_DURATION
#    run evavaloper16ls59sm5hc63h5szj3z7wv27xvw5xfn3xvvdx7 $SAMPLE_DURATION

isJailed(){
    echo $(${CLIENT_NAME} query staking validator $1  \
        --node $EVA_VALIDATOR_URL | grep jailed | awk '{print $2}' | sed 's/,//g')
}

run() {

    # 超级节点 operator 地址
    VALIDATOR=$1
    
    # 取样时间(秒)
    DURATION=$2

    echo "----------------------------------------------------------"

    jailed=$(isJailed $VALIDATOR)

    if $jailed == "true"; then
        echo $VALIDATOR was jailed!!!
        return
    else
        echo ${VALIDATOR}
    fi

    DELEGATOR_ARRAY=($(${CLIENT_NAME} query staking delegations-to $VALIDATOR \
        --node $EVA_VALIDATOR_URL | grep delegator_address | awk '{print $2}' | sed 's/,//g' | sed 's/"//g'))

    sumRewards1=$(sum $DELEGATOR_ARRAY)
    commission1=$(queryCommission $VALIDATOR)

    sleep $DURATION

    sumRewards2=$(sum $DELEGATOR_ARRAY)
    commission2=$(queryCommission $VALIDATOR)

    ((commissionDelta=commission2-commission1))
    ((rewardsDelta=sumRewards2-sumRewards1))
    ((allDelta=sumRewards2-sumRewards1+commissionDelta))

    rate=$(${CLIENT_NAME} query staking validator $VALIDATOR  \
        --node $EVA_VALIDATOR_URL |grep rate|grep -v _|awk '{print $2}' | sed 's/,//g' | sed 's/"//g')

    echo "["$START -- `date`"]期间, 挖矿奖励分配: "
    echo "1. 所有在该超级节点上质押token的delegator奖励总和: "$rewardsDelta
    echo "2. 该超级节点的delegator个数: "${#DELEGATOR_ARRAY[@]}
    echo "3. 该超级节点佣金: "$commissionDelta

    commissionDelta=$[commissionDelta*100]
    echo "4. 计算得出 commission rate: "$((commissionDelta/allDelta))% "= $commissionDelta / ($rewardsDelta + $commissionDelta)"
    echo "5. 实际commission rate配置: "$rate
}

main() {

    # 取样时间(秒)
    SAMPLE_DURATION=6

    validator_array=($(${CLIENT_NAME} query staking validators \
        --node $EVA_VALIDATOR_URL | grep operator_address | awk '{print $2}'| sed 's/,//g' | sed 's/"//g'))

    echo "Total "${#validator_array[@]}" validators"

    for validator in ${validator_array[@]}
    do
        run ${validator} $SAMPLE_DURATION
    done
}

main


