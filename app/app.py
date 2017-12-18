from flask import Flask
import json, os
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'

@app.route('/file')
def read_file():
    read_data = None
    with open('test.html', 'r') as f:
        read_data = f.read()
    return read_data
    
@app.route('/env')
def read_env():
   return json.dumps(dict(os.environ))
