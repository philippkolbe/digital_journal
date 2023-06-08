from flask import Flask, request, jsonify
from dotenv import load_dotenv
import openai
import os

app = Flask(__name__)
load_dotenv()
openai.api_key = os.getenv('OPENAI_API_KEY')

@app.route('/chat', methods=['POST'])
def chat():
    user_message = request.json['message']
    # Send user message to OpenAI and get response
    response = openai.Completion.create(
        engine='davinci',
        prompt=user_message,
        max_tokens=100
    )
    bot_response = response.choices[0].text.strip()

    return jsonify({'response': bot_response})

if __name__ == '__main__':
    app.run()
