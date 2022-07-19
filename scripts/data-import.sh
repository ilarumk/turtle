#!/bin/bash
for file in data/*.json
do
    if [[ -f $file ]]; then
        file=${file##*/}
        basename=${file%.*}
        echo $basename
        curl -XPOST "http://127.0.0.1:9200/sailusfood/recipe/$basename" -d @data/$basename.json
    fi
done

