import boto3
import os

# Initialize Secrets Manager client
secrets_client = boto3.client("secretsmanager", region_name=os.environ.get("AWS_REGION"))

def lambda_handler(event, context):
    token = event.get('authorizationToken', '')

    # Strip "Bearer " prefix if present
    if token.lower().startswith("bearer "):
        token = token[7:]

    # Fetch the expected token from Secrets Manager
    secret_name = os.environ.get("BEARER_TOKEN")
    try:
        secret_value_response = secrets_client.get_secret_value(SecretId=secret_name)
        expected_token = secret_value_response['SecretString']
    except Exception as e:
        print(f"Error retrieving secret: {e}")
        return generate_policy("user", "Deny", event.get("methodArn", "*"))

    # Compare tokens
    if token == expected_token:
        return generate_policy("user", "Allow", event["methodArn"])
    else:
        return generate_policy("user", "Deny", event["methodArn"])

def generate_policy(principal_id, effect, resource):
    if effect and resource:
        return {
            "principalId": principal_id,
            "policyDocument": {
                "Version": "2012-10-17",
                "Statement": [
                    {
                        "Action": "execute-api:Invoke",
                        "Effect": effect,
                        "Resource": resource
                    }
                ]
            }
        }
    return {}
