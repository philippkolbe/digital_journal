import flask
from dotenv import load_dotenv
import openai
import os
import logging
from firebase_admin import auth

def message_from_json(json):
  return create_message(json['role'], json['content'])

def create_message(role, content):
  return {
    'role': role,
    'content': content,
  }

load_dotenv()
openai.api_key = os.getenv('OPENAI_API_KEY')

default_system_message = create_message('system', 'You are a friendly and motivating journaling companion within an app. The chat users now you already - you don’t have to introduce yourself. As users chat with you, you provide guidance for journaling and self-reflection. Your goal is to help users explore their emotions and personal development. By asking simple, non-intrusive questions, you empower users to delve deeper into their thoughts. Always ask one question at a time and await the users answer before asking more questions. Your first answer should be one simple question. Remember to maintain a quiet and supportive presence, akin to a trusted journal. Be very concise in answers.')

def chat(request: flask.Request) -> flask.Response:
  try:
    try:
      # Verify the Firebase ID token in the request header
      auth_header = request.headers.get('Authorization')
      if auth_header == None:
        raise AuthError('Please add an Authorization header')
      id_token = auth_header.split('Bearer ')[1]
      
      if id_token == None or id_token == '':
        raise AuthError('Please provider a Bearer Authorization token')

      decoded_token = auth.verify_id_token(id_token)
    except Exception as err:
      logging.exception(err)
      return flask.jsonify({
        'success': False,
        'error': 'Authentication Error: ' + str(err),
      })

    # The user is authenticated, continue with the function logic
    user_id = decoded_token['uid']
    messages = [message_from_json(json) for json in request.json['messages']]

    if len(messages) == 0 or messages[0]['role'] != 'system':
      messages.insert(0, default_system_message)

    # Send user message to OpenAI and get response
    response = openai.ChatCompletion.create(
      model='gpt-3.5-turbo',
      messages=messages,
      temperature=1.1,
      user=user_id
    )

    choice = response.choices[0]
    bot_response = choice.message.content.strip()
    finish_reason = choice.finish_reason

    return flask.jsonify({
      'success': True,
      'response': bot_response,
      'finish_reason': finish_reason,
    })
  except Exception as err:
    logging.exception(err)
    return flask.jsonify({
      'success': False,
      'error': 'Internal Server Error: ' + str(err),
    })

class AuthError(Exception):
    pass