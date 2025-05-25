def lambda_handler(event, context):
    token = event.get("authorizationToken", "")
    method_arn = event["methodArn"]

    if token == "Bearer secret123":
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
