import boto3
import os
import time

s3_client = boto3.client("s3")
ddb = boto3.resource("dynamodb")

def lambda_handler(event, context):
    bucket_name = event.get("bucket") or os.environ.get("BUCKET_NAME")
    image_key   = event.get("key")

    if not bucket_name:
        return {"statusCode": 400, "body": "Bucket name not provided"}

    download_path = f"/tmp/{os.path.basename(image_key)}"

    # DynamoDB table name from env var
    download_table_name = os.environ.get("DDB")
    download_table = ddb.Table(download_table_name)

    try:
        # Download file from S3
        s3_client.download_file(bucket_name, image_key, download_path)
        print(f"Downloaded {image_key} from {bucket_name} to {download_path}")

        # Record in DynamoDB
        epoch_timestamp = int(time.time())
        download_table.put_item(
            Item={
                "Object": image_key,
                "Timestamp": epoch_timestamp
            }
        )

        return {
            "statusCode": 200,
            "body": f"Image {image_key} downloaded successfully to {download_path} and recorded in DynamoDB"
        }
    except Exception as e:
        print(f"Error downloading file: {e}")
        return {"statusCode": 500, "body": str(e)}

