API_URL="$1"

curl -X POST \
  "${API_URL}" \
  -H "Authorization: Bearer secret123" \
  -H "Content-Type: image/jpeg" \
  --data-binary "@tom-richards.jpg"
