import base64
import boto3
import os
from datetime import datetime

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    bucket = os.environ['BUCKET']
    content_type = event["headers"].get("Content-Type", event["headers"].get("content-type", "application/octet-stream"))

    body = base64.b64decode(event["body"])
    ext = {
        "image/jpeg": "jpg",
        "image/png": "png"
    }.get(content_type, "bin")

    key = f"upload-{datetime.utcnow().isoformat()}.{ext}"
    s3.put_object(Bucket=bucket, Key=key, Body=body, ContentType=content_type)

    return {
        "statusCode": 200,
        "body": f"Image uploaded as {key}"
    }

