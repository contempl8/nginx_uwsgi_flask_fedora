from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return (
        '<!DOCTYPE html>\n'
        '<meta charset="utf-8">\n<title>Smile</title>\n'
        '<h1>Smile</h1>\n<img src="/static_flask/images/smile.png">\n'
    )
