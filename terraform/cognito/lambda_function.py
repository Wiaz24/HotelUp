import os
import requests
import boto3
from typing import Dict, Any

def lambda_handler(event: Dict[str, Any], context: Any) -> Dict[str, Any]:
    try:
        target_url = os.environ['TARGET_URL']
        api_key = os.environ['API_KEY']
        user_pool_id = os.environ['USER_POOL_ID']
        cert_path = '/opt/certs/certificate.pem'

        user_attributes = event['request']['userAttributes']
        payload = {
            'ApiKey': api_key,
            'UserEmail': user_attributes.get('email'),
            'UserId': user_attributes.get('sub'),
        }
        
        response = requests.post(
            url=target_url,
            json=payload,
            headers={'Content-Type': 'application/json'},
            verify=cert_path
        )
        
        response.raise_for_status()
        print(f"Successfully sent user data to backend. Status code: {response.status_code}")

        cognito = boto3.client('cognito-idp')
        cognito.admin_add_user_to_group(
            UserPoolId=user_pool_id,
            Username=user_attributes.get('sub'),
            GroupName='Clients'
        )
        
    except KeyError as e:
        print(f"Missing required environment variable or event attribute: {str(e)}")
        raise
    except requests.exceptions.RequestException as e:
        print(f"Failed to send data to backend: {str(e)}")
        raise
    except Exception as e:
        print(f"Unexpected error: {str(e)}")
        raise
        
    return event