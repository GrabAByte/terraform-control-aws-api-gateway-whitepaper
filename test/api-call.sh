#!/bin/bash

usage () {
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
curl -X POST \
  "${API_URL}/upload" \
  -H "Authorization: Bearer ${BEARER_TOKEN}" \
  -H "Content-Type: image/jpeg" \
  --data-binary "@${IMAGE_FILE}"

## download
curl -X GET \
  "${API_URL}/download" \
  -H "Authorization: Bearer abcfdefg12345678" \
  -H "Content-Type: application/json" \
  -d '{ "bucket": "grababyte-api-whitepaper-bucket", "key": "upload-2025-08-09T16:52:38.494038.jpg" }'

# aws lambda invoke \
#  --function-name download_function \
#  --payload '{
#      "bucket":"grababyte-api-whitepaper-bucket",
#      "key":"upload-2025-08-09T13:00:47.924216.jpg"
#    }' \
#  --cli-binary-format raw-in-base64-out \
#  --region eu-west-2 \
#  response.json
