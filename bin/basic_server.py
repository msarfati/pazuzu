from flask import Flask, request
app = Flask(__name__)


@app.route('/<name>')
def user(name):
    return '<h1>Hola {}!</h1>'.format(name) + \
        'You\'re using {}'.format(request.headers.get('User-Agent'))


@app.route('/')
def index():
    return '<h1>Welcome to the Index.</h1>'

if __name__ == '__main__':
    app.run(debug=True)
