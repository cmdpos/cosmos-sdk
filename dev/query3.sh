#!/usr/bin/env bash

EVA_VALIDATOR_URL=http://18.163.89.47:20181

VALIDATOR=evavaloper16ls59sm5hc63h5szj3z7wv27xvw5xfn3xvvdx7
DELEGATOR_ARRAY=(
eva1zz50hsy2t6d689k4s6qqdxh6nahpqhjvem4yxp
eva1yp6al6p76trt28md3w2xesaupfnmcrrx5l50s6
eva19sf4epggywej4gs2u8ad3m0p9e7yhrgty42wza
eva1x970apxvelzmceky95na6xwagvrh6kfz95t0x8
eva18r0va46sskg8ywq2f2s0g2fz6ssyc9zmnlldcm
eva18gx7ckl03rvw4mrl639am4k0tcsksmg2uasj02
eva1gzj8nerczy92h3nn6lzg6g22vytqdmc2mp6xuh
eva1gyqmmq97c28cxyvmh0uhvxrw06d9hq0l8h20sv
eva1ft40keayad5ffweajdxssstrsg90pvxw7pvuky
eva1ttnyvj87tv4lugs0dyuh35uny9rulfms8jejdk
eva1tkmaag77yd33dzwypna7qstkgx8wne7ngx7mt8
eva1tmgdpczz5z7y3wjps5xvlds74atecn4ttppkdt
eva1v9jksaw4dz6dya6gtjhpplrcxfaye5vl4n79x5
eva1v8vsp80wz02zhqsg8rlqj5hdcugyjhzkxeex9a
eva1va7hatgd75pzaf0p7knp5gxx5ucet34nj9tpxs
eva1wt4g5jj22z5fka5jty8t7a4arjf4mn26udx6nq
eva1wanhdz3ygelva4q7d93x2pf4nsen67gju4rjuu
eva1sf2s9updshdlnkzm0am9hwrdgf2lfxpth4n62t
eva1sn480pea777ktf8fmqazqqawx9sraz073e7wue
eva1j969dh9klyx43ej8s5rrd0j7xa95ym7ncxepa0
eva1nc9rwt4l854mk83gy7n7cxalkva6cqfvws7cu6
eva14qgtwrees3vpuphzj2323navd3qn0mp2yv6e7n
eva1kxuwvj6zt8yhx9d6w5l5mfc0s7gckc69sjrz6c
eva1h7jpq22777tpx86eqm2kpg3qk95pt93zhuazk4
eva1chlf962hqnnknnkrv0hur2x2x5us0m90dmejm2
eva1ekahfrkqens8zq6y736a9t6yyl3xgul9ecpwmw
eva1e7tfnrdzr5wd9wlvmqf5eltxj66dcw2ygdfede
eva16qqjjs8gzehgwqweqv9l825rwensvgnkuvrkqh
eva16ls59sm5hc63h5szj3z7wv27xvw5xfn3s3wmzm
eva1mpgqadadly0qndue49fkld2vptf4jpa4824pzw
eva1mke2ylp6p6am5gvrsdhc3w8yflmyf6grzy4z0k
eva1u2s3fxlqtst7e3n2z2yt3kqk9wuhmhct73dzwl
eva1uvyma94qyvsx9w3tzrgelg5kqmxcmkxj4pk56z
eva1u5gapxpeqxr8etshvfx5w76qu8axkepvdrg9hk
eva1a9u9us0n5gyqku0azsmsuz69vnqyq9veyx9l0w
eva17y267fkaezzz5v2tm0gxzdm02rw7l0dp3zzkd3
eva173d8z3qdf00r59909m8kezrsuuhsff88fu3c3r
eva1lpmu4rdnyugna059exj5p5mmj4rrwksq3um0ja
)

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

sumRewards1=$(sum)
commission1=$(queryCommission $VALIDATOR)

sleep 60

sumRewards2=$(sum)
commission2=$(queryCommission $VALIDATOR)

((commissionDelta=commission2-commission1))
((rewardsDelta=sumRewards2-sumRewards1))
((allDelta=sumRewards2-sumRewards1+commissionDelta))

#echo $rewardsDelta
#echo $commissionDelta
#echo $allDelta

commissionDelta=$[commissionDelta*100]
echo Validator ${VALIDATOR} commission rate: $((commissionDelta/allDelta))%
