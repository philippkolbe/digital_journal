import flask

import main

app = flask.Flask(__name__)


@app.get("/")
def index():
    return main.chat(flask.request)


if __name__ == "__main__":
    # Local development only
    app.run(debug=True)
