#!/bin/bash

# example usage: bash -x api-call.sh https://<API_ID>.execute-api.eu-west-2.amazonaws.com/v1beta1/upload tom-richards.jpg

if [ -z ${1+x} ] && [ -z ${2+x} ]; then
  echo "Arguments are required to run scripting, exiting"
  exit 1
else
  API_URL="$1"
  IMAGE_FILE="$2"
fi

BEARER_TOKEN=$(cat < ~/.bearer | base64 -d)

curl -X POST \
  "${API_URL}" \
  -H "Authorization: Bearer ${BEARER_TOKEN}" \
  -H "Content-Type: image/jpeg" \
  --data-binary "@${IMAGE_FILE}"
