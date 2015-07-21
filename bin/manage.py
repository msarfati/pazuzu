#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Michael Sarfati, 2015

from flask.ext.script import Manager, Shell, Server
from pazuzu import create_app

app = create_app()


def _make_context():
    return dict(app=app,
        # db=db,
        # user_datastore=security.datastore
    )

manager = Manager(app)
manager.add_command("shell", Shell(make_context=_make_context))
manager.add_command("runserver", Server())
# manager.add_command("runserver", Server(port=app.config['PORT']))

if __name__ == '__main__':
    manager.run()
