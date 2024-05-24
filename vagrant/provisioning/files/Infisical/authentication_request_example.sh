#! /bin/bash

curl --location --request POST 'https://192.168.56.100/api/v1/auth/universal-auth/login' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'clientId=<CLIENT ID>' \
--data-urlencode 'clientSecret=<CLIENT SECRET>'