#!/usr/bin/bash
help () {
    echo "ERROR MESSAGE"
    echo "The argument cannot be empty."
    echo "Enter --terms and the list of terms separated by space to generate a word cloud"
    echo "For example: generate_cloud --terms term1 term2 term3 and so on"
}
var=$1
num=$#
terms=($@)
if [ -z "$var" ]
then
    help
elif [ $var = "--terms" ]
then
    term=$2
    if [ -z "$term" ]
    then
        echo "Please enter the terms to generate word cloud"
    else
        (for term in ${terms[@]}
        do
            if [ $term = "--terms" ]
            then
                continue
            else
                echo $term
            fi
        done) > terms.txt
    cloud=$(cat ./terms.txt)
    esearch -db pubmed -query "${cloud[@]}" | efetch -format abstract > cloud.txt
    wordcloud_cli --text cloud.txt --imagefile cloud.png --mask mask.png
    fi
else
    help
fi


