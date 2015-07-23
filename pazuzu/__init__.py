# -*- coding: utf-8 -*-
# Pazuzu by Michael Sarfati, 2015
from flask import Flask


def create_app():
    from .views.base import baseview
    app = Flask(__name__)

    app.config.from_envvar('SETTINGS')
    app.register_blueprint(baseview, url_prefix="/")

    return app
