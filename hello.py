import json

from flask import Flask, request

app = Flask(__name__)


@app.route('/', methods=['GET', 'POST'])
def echo():
    headers = dict(request.headers)
    data = request.get_data().decode('utf-8')

    response = {
        "headers": headers,
        "data": data
    }

    json_response = json.dumps(response, indent=4)
    return json_response, {'Content-Type': 'application/json; charset=utf-8'}


@app.route('/ping', methods=['GET'])
def ping():
    return "PONG"


@app.route('/hello/<string:name>', methods=['GET'])
def hello(name):
    return "Hello %s" % name


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=80)
