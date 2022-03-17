#!/bin/bash
#set -eu

############Creating a file name
temp=`echo "${0}" | cut -d'.' -f2 | cut -d'/' -f2 `
FileName=${temp}_$(date '+%Y%m%d_%H%M%S')

#####Setting env variables
export $(grep -v '^#' .env | xargs -d '\n')

#####executing curls
input="/c/sites.txt" # change for $2

while read -r -e line
do
var=$(echo $line)
echo $var
#$var >> "${FileName}.file"
#echo -e "\n\n\n\n" >> "${FileName}.file"
done < "$input"

#TEMP="/imghp?hl=ru&ogbl"
#curl -vi google.com$TEMP
