from flask import Flask, request, jsonify
from dotenv import load_dotenv
import openai
import os
import logging


def message_from_json(json):
  return create_message(json['role'], json['content'])

def create_message(role, content):
  return {
    'role': role,
    'content': content,
  }

app = Flask(__name__)
load_dotenv()
openai.api_key = os.getenv('OPENAI_API_KEY')

system_message = create_message('system', 'You are a helpful journaling assistant.')

@app.route('/chat', methods=['POST'])
def chat():
  try:
    user_id = request.json['user_id']
    messages = [message_from_json(json) for json in request.json['messages']]
    messages.insert(0, system_message)

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

    return jsonify({
      'success': True,
      'response': bot_response,
      'finish_reason': finish_reason,
    })
  except Exception as err:
    logging.exception(err)
    return jsonify({
      'success': False,
      'error': 'Internal Server Error: ' + str(err),
    })

if __name__ == '__main__':
  app.run()
