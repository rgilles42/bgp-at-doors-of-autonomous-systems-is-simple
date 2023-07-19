#!/bin/bash
if [[ $1 == '' ]]; then
	echo "Please add either 'static' or 'multi' as argument."
	exit 0
fi

for cont_id in $(docker ps -q); do
	if [[ $(docker exec $cont_id hostname | cut -d '_' -f 1) == 'router' ]]; then
		docker cp P2/router_config.sh $cont_id:/ && \
		docker exec $cont_id bash /router_config.sh $1
	fi
done