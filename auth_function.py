def lambda_handler(event, context):
    token = event.get("authorizationToken", "")
    method_arn = event["methodArn"]

    # TODO: purely for purpose of demonstrating auth lambda, this would need to be much more secure
    if token == "Bearer gcmqsoqgaggdjauczjfvdmmsgjrhfdgq":
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
