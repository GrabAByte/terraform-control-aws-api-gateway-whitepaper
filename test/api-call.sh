#!/bin/bash

usage() {
  echo "Error: Arguments are required to run this script, exiting."
  echo "Usage: ./api-call.sh https://<API_ID>.execute-api.<REGION>.amazonaws.com tom-richards.jpg"
}

if [ -z ${1+x} ] && [ -z ${2+x} ]; then
  usage
  exit 1
else
  API_URL="$1"
  IMAGE_FILE="$2"
fi

if [ -z ${3+x} ]; then
  BEARER_TOKEN=$(cat < ~/.bearer)
else
  BEARER_TOKEN="$3"
fi

## upload
UPLOAD_RESPONSE=$(curl -X POST \
  "${API_URL}/upload" \
  -H "Authorization: Bearer ${BEARER_TOKEN}" \
  -H "Content-Type: image/jpeg" \
  --data-binary "@${IMAGE_FILE}")

UPLOAD_FILE=$(echo "${UPLOAD_RESPONSE}" | cut -d ':' -f2-)

## download
curl -X GET \
  "${API_URL}/download?file=${UPLOAD_FILE}" \
  -H "Authorization: Bearer ${BEARER_TOKEN}" \
  -o "/tmp/${UPLOAD_FILE}" &&
  ls -l "/tmp/${UPLOAD_FILE}"
