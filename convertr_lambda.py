import json
import boto3
import base64

def lambda_handler(event, context):
    S3 = boto3.client("s3")
    get_file_content = event["content"]
    decode_content = base64.b64decode(get_file_content)
    s3_upload = S3.put_object(Bucket="convertr-bucket",Key="data.pdf",Body=decode_content)
    expiration = 3600

    presigned_url = s3_client.generate_presigned_url(
        'get_object',
        Params={'Bucket': "convertr-bucket", 'Key': "data.pdf"},
        ExpiresIn=expiration
    )

    return {
        'statusCode': 200,
        'body': json.dumps('The Object is Uploaded successfully!, URL:' presigned_url)
    }
