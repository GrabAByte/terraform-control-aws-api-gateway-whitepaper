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

## upload - generate objects, records and observability
for i in $(seq 1 5); do
  UPLOAD_RESPONSE=$(curl -s -X POST \
    "${API_URL}/upload" \
    -H "Authorization: Bearer ${BEARER_TOKEN}" \
    -H "Content-Type: image/jpeg" \
    --data-binary "@${IMAGE_FILE}") &&
    echo "/upload request #${i} successful"
  sleep 2
done

UPLOAD_FILE=$(echo "${UPLOAD_RESPONSE}" | cut -d ':' -f2-)
echo "File uploaded to the S3 bucket as: ${UPLOAD_FILE}"

## download - generate objects, records and observability
for i in $(seq 1 5); do
  curl -s -X GET \
    "${API_URL}/download?file=${UPLOAD_FILE}" \
    -H "Authorization: Bearer ${BEARER_TOKEN}" \
    -o "${UPLOAD_FILE}" &&
    echo "/download request #${i} successful"
  sleep 3
done

ls -l "${UPLOAD_FILE}"
