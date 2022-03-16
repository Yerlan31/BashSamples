#!/bin/bash
set -eu

################Создание имени файла##############
FileName=`echo "${0}" | cut -d'.' -f2 | cut -d'/' -f2 `
echo Hello world >  ${FileName}_$(date '+%Y%m%d_%H%M').txt

#####Отправка курлов в цикле
input="/c/sites.txt"
while IFS= read -r line
do
  echo "$line"
  curl "$line"
done < "$input"
