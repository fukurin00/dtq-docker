#!/bin/sh

## check if there is synerex-network

sx=`docker network ls | grep synerex-network | grep -c ''`

echo count is $sx

if [ $sx -eq 0 ]; then
    docker network create synerex-network
    echo "synerex-network created!"    
else
    echo "synerex-network already existing"
fi


docker run  -d --rm --name nodeserv --network synerex-network -p 9990:9990 nkawa/synerex_nodeserv -addr 0.0.0.0
docker run  -d --rm --name sxserv --network synerex-network -p 10000:10000 nkawa/synerex_server -nodeaddr nodeserv --servaddr sxserv
