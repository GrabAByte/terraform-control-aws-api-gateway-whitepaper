import boto3
import os
import base64
from datetime import datetime
import time

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    ddb = boto3.resource('dynamodb')

    bucket = os.environ['BUCKET']
    table_name = os.environ['DDB']
    table = ddb.Table(table_name)

    content_type = event["headers"].get(
        "Content-Type",
        event["headers"].get("content-type", "application/octet-stream")
    )

    # Decode incoming file
    body = base64.b64decode(event["body"])

    # Determine file extension
    ext = {
        "image/jpeg": "jpg",
        "image/png": "png"
    }.get(content_type, "bin")

    # Create unique object key
    key = f"upload-{datetime.utcnow().isoformat()}.{ext}"

    # Upload to S3
    s3.put_object(Bucket=bucket, Key=key, Body=body, ContentType=content_type)

    # Store record in DynamoDB
    epoch_timestamp = int(time.time())
    table.put_item(
        Item={
            "Object": key,
            "Timestamp": epoch_timestamp
        }
    )

    return {
        "statusCode": 200,
        "body": f"Image uploaded successfully to {bucket}/{key} and recorded in DynamoDB"
    }
