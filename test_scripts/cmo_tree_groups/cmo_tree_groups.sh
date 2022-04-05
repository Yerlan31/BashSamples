#!/bin/bash
#set -eu

####CREATING A JSON-CHECK FUNCTION
function jscheck() {
#echo $1
if jq -e . >/dev/null 2>&1 <<<"$1"; then
return 0
else 
return 1
fi 
}

############Creating a file name
temp=`echo "${0}" | cut -d'.' -f2 | cut -d'/' -f2 `
FileName=${temp}_$(date '+%Y%m%d_%H%M%S')

#####Setting env variables
export $(grep -v '^#' ./../.env | xargs -d '\n')

#####executing curls

echo "1) Получение дерева хранилища..."
request='curl -kviX GET ${X_TEST_VAULT_ADDR}/v1/${X_TEST_VAULT_CMO_NAME}/storages/tree/${X_TEST_VAULT_CMO_TENANT}/${X_TEST_VAULT_EMPLOYEEID} -H "X-Vault-Token: ${X_TEST_VAULT_TOKEN}" -H "Content-Type: application/json" --write-out '%{http_code}' -H "Connection: close"'
echo $request  >> "${FileName}.file"
eval $request &>> "${FileName}.file"
respcode=`tail -n 2 "${FileName}.file" | head -n 1 ` 
content=`tail -n 3 "${FileName}.file" | head -n 1 `
echo -e "\n\n\n\n" >> "${FileName}.file"
#проверка поля
field=`echo $content | jq -r '.data.nodes'`
#проверка http response
expectedresult=200
if [[ $respcode -eq $expectedresult && $field == "" ]]; then
    if jscheck $content; then echo "OK. Было получено пустое дерево хранилища ${X_TEST_VAULT_CMO_TENANT}" 
    else echo echo "FAIL. Было получено дерево хранилища ${X_TEST_VAULT_CMO_TENANT} с данными"
    fi
else
echo "FAIL. Было получено дерево хранилища ${X_TEST_VAULT_CMO_TENANT} с данными"
fi

echo -e "\nНеобходимо  добавить пользователя в группы AD ALL-GA-SecMan-${X_TEST_VAULT_CMO_TENANT}-A-${X_TEST_VAULT_CMO_MODULE}-${X_TEST_VAULT_CMO_STRG_TYPE}-${X_TEST_VAULT_CMO_ADD_LEVEL}-aa", "ALL-GA-SecMan-${X_TEST_VAULT_CMO_TENANT}-A-${X_TEST_VAULT_CMO_MODULE}-${X_TEST_VAULT_CMO_STRG_TYPE}-${X_TEST_VAULT_CMO_ADD_LEVEL}-aс и продолжить выполнение теста"
#read 

echo "2) Получение дерева хранилища..."
request='curl -kviX GET ${X_TEST_VAULT_ADDR}/v1/${X_TEST_VAULT_CMO_NAME}/storages/tree/${X_TEST_VAULT_CMO_TENANT}/${X_TEST_VAULT_EMPLOYEEID} -H "X-Vault-Token: ${X_TEST_VAULT_TOKEN}" -H "Content-Type: application/json" --write-out '%{http_code}' -H "Connection: close"'
echo $request  >> "${FileName}.file"
eval $request &>> "${FileName}.file"
respcode=`tail -n 2 "${FileName}.file" | head -n 1 ` 
content=`tail -n 3 "${FileName}.file" | head -n 1 `
echo -e "\n\n\n\n" >> "${FileName}.file"
#проверка поля
field=`echo $content | jq -r '.data.nodes'`
#проверка http response
expectedresult=200
if [[ $respcode -eq $expectedresult && $field == "" ]]; then
    if jscheck $content; then echo "OK. Было получено пустое дерево хранилища ${X_TEST_VAULT_CMO_TENANT}" 
    else echo echo "FAIL. Было получено дерево хранилища ${X_TEST_VAULT_CMO_TENANT} с данными"
    fi
else
echo "FAIL. Было получено дерево хранилища ${X_TEST_VAULT_CMO_TENANT} с данными"
fi

echo -e "\nНеобходимо  добавить пользователя в группы AD ALL-GA-SecMan-${X_TEST_VAULT_CMO_TENANT}-A-aa и продолжить выполнение теста"
#read 

echo "3) Получение дерева хранилища..."
request='curl -kviX GET ${X_TEST_VAULT_ADDR}/v1/${X_TEST_VAULT_CMO_NAME}/storages/tree/${X_TEST_VAULT_CMO_TENANT}/${X_TEST_VAULT_EMPLOYEEID} -H "X-Vault-Token: ${X_TEST_VAULT_TOKEN}" -H "Content-Type: application/json" --write-out '%{http_code}' -H "Connection: close"'
echo $request  >> "${FileName}.file"
eval $request &>> "${FileName}.file"
respcode=`tail -n 2 "${FileName}.file" | head -n 1 ` 
content=`tail -n 3 "${FileName}.file" | head -n 1 `
echo -e "\n\n\n\n" >> "${FileName}.file"
#проверка поля
field=`echo $content | jq -r '.data.nodes'`
#проверка http response
expectedresult=200
if [[ $respcode -eq $expectedresult && $field == "" ]]; then
    if jscheck $content; then echo "OK. Было получено пустое дерево хранилища ${X_TEST_VAULT_CMO_TENANT}" 
    else echo echo "FAIL. Было получено дерево хранилища ${X_TEST_VAULT_CMO_TENANT} с данными"
    fi
else
echo "FAIL. Было получено дерево хранилища ${X_TEST_VAULT_CMO_TENANT} с данными"
fi

echo -e "\nНеобходимо  добавить пользователя в группы AD ALL-GA-SecMan-${X_TEST_VAULT_CMO_TENANT}-A-${X_TEST_VAULT_CMO_MODULE}-${X_TEST_VAULT_CMO_STRG_TYPE}-${X_TEST_VAULT_CMO_ADD_LEVEL}-ao и продолжить выполнение теста"
#read 

echo "4) Получение дерева хранилища..."
request='curl -kviX GET ${X_TEST_VAULT_ADDR}/v1/${X_TEST_VAULT_CMO_NAME}/storages/tree/${X_TEST_VAULT_CMO_TENANT}/${X_TEST_VAULT_EMPLOYEEID} -H "X-Vault-Token: ${X_TEST_VAULT_TOKEN}" -H "Content-Type: application/json" --write-out '%{http_code}' -H "Connection: close"'
echo $request  >> "${FileName}.file"
eval $request &>> "${FileName}.file"
respcode=`tail -n 2 "${FileName}.file" | head -n 1 ` 
content=`tail -n 3 "${FileName}.file" | head -n 1 `
echo -e "\n\n\n\n" >> "${FileName}.file"
#проверка поля и сохранение в файл
field=`echo $content | jq -r '.data.nodes'`
field=$(echo $field | sed 's/\\//g' )
echo $field > data.json
#проверка http response
expectedresult=200

#проверка с файлом

if [[ $respcode -eq $expectedresult && $field == "" ]]; then
echo "OK. Было получено пустое дерево хранилища ${X_TEST_VAULT_CMO_TENANT}" 
else
echo "FAIL. Было получено дерево хранилища ${X_TEST_VAULT_CMO_TENANT} с данными"
fi

count=$(jq length ./data.json)
count=$(($count-1))
for tmp in $( seq  0 $count )
do
echo $field | jq -r ".[$tmp].id" 
if [[$_ == ${X_TEST_VAULT_CMO_TENANT}_${X_TEST_VAULT_CMO_MODULE}_${X_TEST_VAULT_CMO_STRG_TYPE}_${X_TEST_VAULT_CMO_ADD_LEVEL}]]; then
num=$tmp
done 



while read -r -e line
do
eval echo $line
done < "expected.txt"
# в цикле планирую сделать сравнение с ожидаемой реакцией   
