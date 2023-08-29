import jwt
from functools import wraps
from flask import request, jsonify

def validate_token(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        auth_token = request.headers.get('Authorization')
        if not auth_token:
            return jsonify({'message': 'Missing authentication token'}), 401

        try:
            decoded_token = auth.verify_id_token(auth_token)
            # 'decoded_token' contains the token payload, including the 'user_id'

        except jwt.ExpiredSignatureError:
            return jsonify({'message': 'Token has expired'}), 401

        except auth.AuthError as e:
            return jsonify({'message': str(e)}), 401

        return f(*args, **kwargs)

    return decorated_function
