import re

def lambda_handler(event, context):
    token = event.get('authorizationToken', '')

    # Strip "Bearer " prefix if present
    if token.lower().startswith("bearer "):
        token = token[7:]

    # Validation checks
    # This is a time-constrained basic example of an authorizer
    is_valid_length = len(token) == 16
    has_letters = any(c.isalpha() for c in token)
    has_numbers = any(c.isdigit() for c in token)
    is_alphanumeric = token.isalnum()

    if is_valid_length and has_letters and has_numbers and is_alphanumeric:
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
