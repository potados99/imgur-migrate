#!/bin/bash

BLOG_PATH="/Users/potados/Documents/GitHub/potados99.github.io"

for entry in $BLOG_PATH/_posts/*
do 
    for embed in $(grep "$entry" -e '\!\[.*\]\(.*\)')
    do
        url_part=$(echo "$embed" | sed -n 's/^.*(\(.*\)).*$/\1/p')

        if [[ $url_part == "" ]]
        then
            continue
        fi

        if [[ $url_part == *imgur* ]]
        then
            continue
        fi

        if [[ $url_part == http* ]]
        then
            url="$url_part"
        else
            continue
        fi

        echo $entry
        echo $url       

   done

done
