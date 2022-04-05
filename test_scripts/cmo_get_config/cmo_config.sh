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

echo "1) Получение конфигураций движка..."
request='curl -kviX GET ${X_TEST_VAULT_ADDR}/v1/${X_TEST_VAULT_CMO_NAME}/config -H "X-Vault-Token: ${X_TEST_VAULT_TOKEN}" -H "X-Vault-Request: true" -H "Content-Type: application/json" --write-out '%{http_code}' -H "Connection: close"'
content=$(curl -${X_TEST_VAULT_CURL_OPTIONS2} GET ${X_TEST_VAULT_ADDR}/v1/${X_TEST_VAULT_CMO_NAME}/config -H "X-Vault-Token: ${X_TEST_VAULT_TOKEN}" -H "X-Vault-Request: true" -H "Content-Type: application/json" -H "Connection: close")
echo $request  >> "${FileName}.file"
eval $request &>> "${FileName}.file"
respcode=`tail -n 2 "${FileName}.file" | head -n 1 ` 
echo -e "\n\n\n\n" >> "${FileName}.file"
#проверка поля template
template=`echo $content | jq -r '.data.secrets_group_policy'`
#проверка http response
expectedresult=200
if [[ $respcode -eq $expectedresult && $template != "" ]]; then
   echo "OK. Была полупчена конфигурация с необходимыми полями" 
else
echo "FAIL. Конфигурация не была получена или получена с неверными полями" 
fi

