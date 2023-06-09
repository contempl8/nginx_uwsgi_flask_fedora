from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return (
        '<!DOCTYPE html>\n'
        '<meta charset="utf-8">\n<title>Landing Page</title>\n'
        '<h1>Landing Page</h1>\n'
    )