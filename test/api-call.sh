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

if [ -z ${3+x} ]; then
  BEARER_TOKEN=$(cat < ~/.bearer | base64 -d)
else
  BEARER_TOKEN="$3"
fi

curl -X POST \
  "${API_URL}" \
  -H "Authorization: Bearer ${BEARER_TOKEN}" \
  -H "Content-Type: image/jpeg" \
  --data-binary "@${IMAGE_FILE}"
