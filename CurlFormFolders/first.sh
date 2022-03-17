#!/bin/bash
#/set -eu

################Создание имени файла##############
FileName=`echo "${0}" | cut -d'.' -f2 | cut -d'/' -f2 `
#echo Hello world >  ${FileName}_$(date '+%Y%m%d_%H%M')

#####Отправка курлов в цикле / заменитьна параметр
input="/c/sites.txt"

while read -r -e line
do
var=$(echo $line)
echo $var
curl -v -i "$var" >> ${FileName}_$(date '+%Y%m%d_%H%M')
done < "$input"
