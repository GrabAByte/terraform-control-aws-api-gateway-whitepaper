import boto3
import os

s3_client = boto3.client("s3")

def handler(event, context):
    bucket_name = event.get("bucket") or os.environ.get("BUCKET_NAME")
    image_key   = event.get("key") or "example.jpg"  # file name in S3

    if not bucket_name:
        return {"statusCode": 400, "body": "Bucket name not provided"}

    download_path = f"/tmp/{os.path.basename(image_key)}"

    try:
        s3_client.download_file(bucket_name, image_key, download_path)
        print(f"Downloaded {image_key} from {bucket_name} to {download_path}")
        return {
            "statusCode": 200,
            "body": f"Image {image_key} downloaded successfully to {download_path}"
        }
    except Exception as e:
        print(f"Error downloading file: {e}")
        return {"statusCode": 500, "body": str(e)}
