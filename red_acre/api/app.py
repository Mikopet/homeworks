import psutil
from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/')
def index():
    return "healthchecked"

@app.route('/stats')
def stats():
    cpu = psutil.cpu_percent()
    ram = psutil.virtual_memory().percent

    return jsonify({"ram": ram, "cpu": cpu})


if __name__ == "__main__":
    import os
    app.run(host="0.0.0.0", port=int(os.getenv('APP_PORT', 5000)))

