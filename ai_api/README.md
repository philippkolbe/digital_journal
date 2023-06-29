## Overview
The idea is that the `main.py` file describes functions that can be built to google cloud.
The `app.py` is for local development and imports all the functions from main and deploys them in a flask app.
Note that the filenames are given by the libraries.

## Setup
We need an OpenAI API key stored in the `.env` file under `OPENAI_API_KEY`.

## Local development
### Docker
Either start the docker with the Dockerfile:
`docker build -t ai-api .`

### Flask
Or run this command:
`flask run --host localhost --port 5001`

## Deployment
To deploy to the google cloud run this while you're in the root directory of the python ai_api:
`gcloud functions deploy chat --env-vars-file .env.yaml --runtime python311 --trigger-http --allow-unauthenticated`