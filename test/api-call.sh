#!/bin/bash

usage () {
  echo "Error: Arguments are required to run this script, exiting."
  echo "Usage: ./api-call.sh https://<API_ID>.execute-api.<REGION>.amazonaws.com/<STAGE>/<PATH> tom-richards.jpg"
}

if [ -z ${1+x} ] && [ -z ${2+x} ]; then
  usage
  exit 1
else
  API_URL="$1"
  IMAGE_FILE="$2"
fi

## hardcoded for purposes of demonstrating lambda authorization
BEARER_TOKEN=$(cat < ~/.bearest | base64 -d)

curl -X POST \
  "${API_URL}" \
  -H "Authorization: Bearer ${BEARER_TOKEN}" \
  -H "Content-Type: image/jpeg" \
  --data-binary "@${IMAGE_FILE}"
