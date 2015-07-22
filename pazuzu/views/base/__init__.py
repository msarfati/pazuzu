# -*- coding: utf-8 -*-
# Pazuzu by Michael Sarfati, 2015

import flask

baseview = flask.Blueprint(
    'baseview',
    __name__,
    template_folder='templates',
    static_folder='static'
)


@baseview.route('/')
def index():
    return flask.render_template("index.html", browser=flask.request.headers.get('User-Agent'))
    # return '<h1>Test!</h1>'


@baseview.route('user/<name>')
def user(name):
    return "<h1>Good day {}\nWelcome...</h1>".format(name.capitalize())
    # return '<h1>Test!</h1>'


@baseview.route('cart/<item>')
def cart(item):
    resp = "<h1>Cart</h1>\n<ul>\n"
    for i in item.split(','):
        resp += "<li>{}</li>\n".format(i)
    resp += "</ul>"
    return resp
    # return '<h1>Test!</h1>'
