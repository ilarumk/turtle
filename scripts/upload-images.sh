#!/bin/bash
for file in data/*.json
do
    if [[ -f $file ]]; then
	image=`cat $file | jq .image`
	if [ $image == null ]; then
		echo $image;
	else
		echo $image;
		
	fi
        #curl -XPOST "http://127.0.0.1:9200/sailusfood/recipe/$basename" -d @data/$basename.json
    fi
done

