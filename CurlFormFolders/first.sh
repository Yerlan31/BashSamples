#!/bin/bash
#set -eu

################Создание имени файла##############
temp=`echo "${0}" | cut -d'.' -f2 | cut -d'/' -f2 `
FileName=${temp}_$(date '+%Y%m%d_%H%M%S')

#####Отправка курлов в цикле / заменитьна параметр
input="/c/sites.txt" #$2

while read -r -e line
do
var=$(echo $line)
echo $var
$var >> "${FileName}.file"
echo -e "\n\n\n\n" >> "${FileName}.file"
done < "$input"

