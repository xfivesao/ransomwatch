#!/bin/zsh

set -e

if ! `nc -z localhost 9050`; then
    echo "localhost:9050 socksproxy required!"
    exit 1
fi

echo

exclusions=`cat assets/sources.exclusions`
total_exclusions=`echo ${exclusions} | wc -w | sed -E -e 's/^[[:space:]]*//'`

random_useragent=`cat assets/useragents.txt | shuf -n 1`

ransomwatch_groups=`jq '.[].locations[].fqdn' groups.json -r`
if [ $? -ne 0 ]; then
    echo "failed to read file ransomwatch/groups.json"
    exit 1
fi
ransomwatch_groups_count=`echo $ransomwatch_groups | wc -w | tr -d ' '`
echo "tracking ${ransomwatch_groups_count} hosts | local:groups.json"
echo "excluding ${total_exclusions} hosts | local:assets/fetch.exclusions"
echo

googlesheCZJ=`curl -s 'https://docs.google.com/spreadsheets/d/1cH4KCZJvggoHPAbk0u08Wu1vSo9ygx47QfhKD-W0TQ0/gviz/tq?tqx=out:csv' -H 'User-Agent: '${random_useragent}''`
if [ $? -ne 0 ]; then
    echo "failed to fetch from googlesheets:1cH4KCZJ"
    exit 1
fi
googlesheCZJ_parse=`echo $googlesheCZJ | cut -d ',' -f 3 | grep onion | sed -E -e 's/^[[:space:]]*//' -e 's/^"//' -e 's/"$//' -e 's:/*$::' -e 's/onion.ly/onion/g' -e 's/http:\/\///' -e 's/https:\/\///' | cut -f1 -d"/"`
googlesheCZJ_count=`echo ${googlesheCZJ_parse} | wc -w | sed -E -e 's/^[[:space:]]*//'`
echo "${googlesheCZJ_count} | googlesheets:1cH4KCZJ"

rgs=`curl -s --socks5-hostname localhost:9050 ransomwr3tsydeii4q43vazm7wofla5ujdajquitomtd47cxjtfgwyyd.onion -H 'User-Agent: '${random_useragent}''`
if [ $? -ne 0 ]; then
    echo "failed to fetch from onion:ransomwr3"
    exit 1
fi
rgs_parse=`echo ${rgs} | sed -E -e 's_.*://([^/@]*@)?([^/:]+).*_\2_' | grep onion | cut -d '"' -f 1`
rgs_count=`echo ${rgs_parse} | wc -w | sed -E -e 's/^[[:space:]]+//' -e 's/[[:space:]]+$//'`
echo "${rgs_count} | onion:ransomwr3"

# echo "fetching from clearnet:darkfeedio"
# dkfeed=`curl -s  -H 'User-Agent: '${random_useragent}'' https://darkfeed.io/ransomwiki/`
# if [ $? -ne 0 ]; then
#     echo "failed to fetch from clearnet:darkfeedio"
#     exit 1
# fi
# dkfeed_parse=`echo ${dkfeed} | grep '</td><td class="column-2">TOR</td><td class="column-3"><a href="' | cut -d '"' -f 8 | sed -e 's/.onion.ly/.onion/g' -e 's/.onion.ws/.onion/g' -E -e 's_.*://([^/@]*@)?([^/:]+).*_\2_'`
# dkfeed_count=`echo ${dkfeed_parse} | wc -w | sed -E -e 's/^[[:space:]]+//' -e 's/[[:space:]]+$//'`
# echo "${dkfeed_count}"

ddcti_ransomgang=`curl -s https://raw.githubusercontent.com/fastfire/deepdarkCTI/main/ransomware_gang.md  -H 'User-Agent: '${random_useragent}''`
if [ $? -ne 0 ]; then
    echo "failed to fetch from github:deepdarkCTI:ransomgang"
    exit 1
fi
ddcti_ransomgang_parse=`echo ${ddcti_ransomgang} | sed -E -e 's_.*://([^/@]*@)?([^/:]+).*_\2_' | grep onion | cut -d ' ' -f 1 | cut -d '|' -f 1`
ddcti_ransomgang_count=`echo ${ddcti_ransomgang_parse} | wc -w | sed -E -e 's/^[[:space:]]*//'`
echo "${ddcti_ransomgang_count} | github:deepdarkCTI:ransomgang"

ddcti_maas=`curl -s https://raw.githubusercontent.com/fastfire/deepdarkCTI/main/maas.md -H 'User-Agent: '${random_useragent}''`
if [ $? -ne 0 ]; then
    echo "failed to fetch from github:deepdarkCTI:maas"
    exit 1
fi
ddcti_maas_parse=`echo ${ddcti_maas} | sed -E -e 's_.*://([^/@]*@)?([^/:]+).*_\2_' | grep onion | cut -d ' ' -f 1 | cut -d '|' -f 1`
ddcti_maas_count=`echo ${ddcti_maas_parse} | wc -w | sed -E -e 's/^[[:space:]]*//'`
echo "${ddcti_maas_count} | github:deepdarkCTI:maas"

ddcti_markets=`curl -s https://raw.githubusercontent.com/fastfire/deepdarkCTI/main/markets.md -H 'User-Agent: '${random_useragent}''`
if [ $? -ne 0 ]; then
    echo "failed to fetch from github:deepdarkCTI:markets"
    exit 1
fi
ddcti_markets_parse=`echo ${ddcti_markets} | sed -E -e 's_.*://([^/@]*@)?([^/:]+).*_\2_' | grep onion | cut -d ' ' -f 1 | cut -d '|' -f 1`
ddcti_markets_count=`echo ${ddcti_markets_parse} | wc -w | sed -E -e 's/^[[:space:]]*//'`
echo "${ddcti_markets_count} | github:deepdarkCTI:markets"

ddcti_forum=`curl -s https://raw.githubusercontent.com/fastfire/deepdarkCTI/main/forum.md -H 'User-Agent: '${random_useragent}''`
if [ $? -ne 0 ]; then
    echo "failed to fetch from github:deepdarkCTI:forum"
    exit 1
fi
ddcti_forum_parse=`echo ${ddcti_forum} | sed -E -e 's_.*://([^/@]*@)?([^/:]+).*_\2_' | grep onion | cut -d ' ' -f 1 | cut -d '|' -f 1`
ddcti_forum_count=`echo ${ddcti_forum_parse} | wc -w | sed -E -e 's/^[[:space:]]*//'`
echo "${ddcti_forum_count} | github:deepdarkCTI:forum"

gistteix=`curl -s https://gist.githubusercontent.com/teixeira0xfffff/3ac8d9c4bf113e56533299b2da8c856b/raw/4e70ff99a7af2a86f720de65d5218f7b9c9f21d0/ransomwarefeed.csv -H 'User-Agent: '${random_useragent}''`
if [ $? -ne 0 ]; then
    echo "failed to fetch from gist:teixeira0xfffff:ransomwarefeed.csv"
    exit 1
fi
gistteix_parse=`echo ${gistteix} | cut -d ',' -f 2 | sed -E -e 's_.*://([^/@]*@)?([^/:]+).*_\2_'`
gistteix_count=`echo ${gistteix_parse} | wc -w | sed -E -e 's/^[[:space:]]*//'`
echo "${gistteix_count} | gist:teixeira0xfffff:ransomwarefeed.csv"

hosts=`echo "${googlesheCZJ_parse} ${gistteix_parse} ${rgs_parse} ${ddcti_ransomgang_parse} ${ddcti_maas_parse} ${ddcti_markets_parse} ${ddcti_forum_parse} ${dkfeed_parse}" | tr ' ' '\n' | sort -u | tr '[:upper:]' '[:lower:]'`
hosts=`echo "${hosts}" | grep -v -E "${exclusions}"`
total_unique_hosts=`echo "${hosts}" | wc -w | sed -E -e 's/^[[:space:]]*//'`
echo
echo "${total_unique_hosts}  | merge-unique count"
hosts=`echo "${hosts}" | sed -E -e '/^[[:space:]]*$/d' -e 's/url//'`
found=False

echo

while read -r host; do
    if ! echo "${ransomwatch_groups}" | grep -q "${host}"; then
        found=True
        echo "${host}"
        echo "${ddcti_ransomgang} ${ddcti_maas} ${ddcti_markets} ${ddcti_forum} ${dkfeed} ${rgs}" | grep "${host}"
    fi
done <<< "${hosts}"

if [ "${found}" = "False" ]; then
    echo "no untracked hosts found"
fi
