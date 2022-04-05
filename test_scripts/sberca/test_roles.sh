#!/bin/bash
#set -eu
if [[ -z $1 ]]; then
echo "Введите путь к файлу с CURL запросами:"
read -r -e input
else
input=$1
fi
############Creating a file name
temp=`echo "${0}" | cut -d'.' -f2 | cut -d'/' -f2 `
FileName=${temp}_$(date '+%Y%m%d_%H%M%S')

#####Setting env variables
export $(grep -v '^#' ./../.env | xargs -d '\n')

#####executing curls
#input=$1 # change for $2

while read -r -e line
do
line=$(echo -e $line)
eval echo $line &>> "${FileName}.file"
eval $line &>> "${FileName}.file"
if [[ $? -eq 0 ]]; then
echo "OK."
else
echo "FAIL."
fi
echo -e "\n\n\n\n" >> "${FileName}.file"

done < "$input"
