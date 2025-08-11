import boto3
import base64
import os
import time

s3 = boto3.client("s3")
ddb = boto3.resource("dynamodb")

def lambda_handler(event, context):
    # Get the filename from query parameters
    file_name = event["queryStringParameters"]["file"]
    bucket_name = os.environ["BUCKET"]

    # DynamoDB table name from env var
    download_table_name = os.environ.get("DDB")
    download_table = ddb.Table(download_table_name)

    # Download file from S3
    s3_response = s3.get_object(Bucket=bucket_name, Key=file_name)
    file_bytes = s3_response["Body"].read()

    # Record in DynamoDB
    epoch_timestamp = int(time.time())
    download_table.put_item(
        Item={
            "Object": file_name,
            "Timestamp": epoch_timestamp
        }
    )

    # Return as Base64-encoded binary (API Gateway needs this for binary files)
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/octet-stream",
            "Content-Disposition": f"attachment; filename={file_name}"
        },
        "isBase64Encoded": True,
        "body": base64.b64encode(file_bytes).decode("utf-8")
    }

