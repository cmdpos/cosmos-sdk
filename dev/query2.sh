#!/usr/bin/env bash
date

queryRewards() {
    res=$(gaiacli query distr rewards $1 $2 --node http://18.163.89.47:20181 -o text)
    echo ${res/neva/}
}

a=$(queryRewards eva1qnkgg9h04v4avc79lzqj9tgdztzlw4e8454mvm evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3)
res1=${a/neva/}
echo $res1
#sleep 10
a=$(queryRewards eva1qnkgg9h04v4avc79lzqj9tgdztzlw4e8454mvm evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3)
res2=${a/neva/}
echo $res2

res1=13464167686233333333
res2=13464188006633333333
((diff=res2-res1))
echo $diff

exit


gaiacli query distr rewards eva1qnkgg9h04v4avc79lzqj9tgdztzlw4e8454mvm  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text
gaiacli query distr rewards eva1pjx74f0l6nvwx857e8m5x78fepph4rrexq5dh5  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text
gaiacli query distr rewards eva19qv9zx0a0p2l02kcfrndv6k99wknadu04twzmv  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text
gaiacli query distr rewards eva19gcs0mp6fsusnmuxzsjrza97srfzv3mu5kdn5x  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text
gaiacli query distr rewards eva18h38cm2eap4k5jxetwwk4yq5zjze3wfsmlxpc4  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text
gaiacli query distr rewards eva1fsvvrkwvlh7084mwlpjek4vjm04enljejpl7z4  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text
gaiacli query distr rewards eva1dukare522acjd0up8ll3tpeh7rdt35q7jlu2r6  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text
gaiacli query distr rewards eva10kclpxhy9mxavdvyg3k20x9jfqqn7rlkyxz500  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text
gaiacli query distr rewards eva10hs433nww8pv5ru0r4x3xrm64xgwqgavdf6yxe  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text
gaiacli query distr rewards eva136ytju4l3twf2jjxgd7etr8527m5q9acp89glw  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text
gaiacli query distr rewards eva1jqr46kdxsnk7h8tnkh96e5uglvalxxawye5k8j  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text
gaiacli query distr rewards eva1j969dh9klyx43ej8s5rrd0j7xa95ym7ncxepa0  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text
gaiacli query distr rewards eva14pevscmc7lvnkmkfutp09wcn0ecgaldxsna03m  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text
gaiacli query distr rewards eva1ht5rs8d3sgy9882yrvcd79phskc70q2affm8nj  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text
gaiacli query distr rewards eva1he7hvqaycmgw0h3x56tku8jye5tj683z88tyax  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text
gaiacli query distr rewards eva1c8sfzqhtatquq07fxn2fj4vt6qzarmnkg4xr9h  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text
gaiacli query distr rewards eva1c3yhug3ztfkujq6unktdk9h9nmduk7fzackq00  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text
gaiacli query distr rewards eva16ttau6apv0fvh0m8e0tk2drkdvfaxlapt4mvdh  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text
gaiacli query distr rewards eva167qjyr23fcm50ptwpupa67v8ef5jk7keuap5fu  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text
gaiacli query distr rewards eva1uyvqg0z59st95x9hy4tde037r2x6tqev4f2w5k  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text
gaiacli query distr rewards eva1uxy3cldwdyxhzmauh4tdjg0uyfdrqcmr0mdf9t  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text
gaiacli query distr rewards eva17w56q0yzuvf42z9k0zrlrvlezect2jvxuauset  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text

gaiacli query distr commission  evavaloper1pjx74f0l6nvwx857e8m5x78fepph4rresakmn3 --node http://18.163.89.47:20181 -o text



