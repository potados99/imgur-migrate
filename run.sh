#!/bin/bash

BLOG_PATH="/home/potados/Temp/potados99.github.io"

for entry in $BLOG_PATH/_posts/*
do 
    echo "$entry"
    for embed in $(grep "$entry" -e '\!\[.*\]\(.*\)')
    do
        url=$(echo "$embed" | sed -n 's/^.*(\(.*\)).*$/\1/p')

        if [[ $url == "" ]]
        then
            continue
        fi

        if [[ $url == *imgur* ]]
        then
            # already done
            echo "The url($url) is already on imgur. pass."
            echo ""
            continue 
        fi

        if [[ $url == /asset* ]]
        then
            # make it absolute
            url="$BLOG_PATH$url"
        fi
 
        read -n 1 -p "Do you want to upload the following image? [y/n/q] $url" ynq

        if [[ "$ynq" == "y" ]]
        then 
            echo ""
            echo "OK. keep going."
        else
            echo ""
            echo "Pass."
            echo ""
            continue
        fi

        echo "Uploading image at $url to imgur."

        imgur_url=$(./imgur.sh $url)
        result=$?

        if [ $result -eq 0 ]
        then
            echo "Upload succeeded."
        else
            echo "Upload failed!"
            echo ""
            continue
        fi

        echo "Image at $url is now available at $imgur_url"
        
        sed -i '' "s|$url|$imgur_url|g" $entry

        echo "Replaced image url in markdown."
        echo ""
    done

done
