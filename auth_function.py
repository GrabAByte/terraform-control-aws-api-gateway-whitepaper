def lambda_handler(event, context):
    token = event.get("authorizationToken", "")
    method_arn = event["methodArn"]

    secret_name = os.environ['TOKEN']
    region_name = "eu-west-2"

    # Create a Secrets Manager client
    session = boto3.session.Session()
    client = session.client(
        service_name='secretsmanager',
        region_name=region_name
    )

    try:
        get_secret_value_response = client.get_secret_value(
            SecretId=secret_name
        )
    except ClientError as e:
        raise e

    secret = get_secret_value_response['SecretString']

    if token == secret:
        return {
            "principalId": "user123",
            "policyDocument": {
                "Version": "2012-10-17",
                "Statement": [{
                    "Action": "execute-api:Invoke",
                    "Effect": "Allow",
                    "Resource": method_arn
                }]
            }
        }
    else:
        raise Exception("Unauthorized")
