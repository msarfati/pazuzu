# -*- coding: utf-8 -*-
# Pazuzu by Michael Sarfati

from setuptools import setup

version = '0.0.1'

setup(version=version,
    name='pazuzu',
    description="Wi-Fi management frontend",
    packages=[
        "pazuzu",
        "pazuzu.views",
        "pazuzu.views.base",
    ],
    scripts=[
        # "bin/runserver.py",
        "bin/manage.py",
        "bin/basic_server.py",
    ],
    long_description="""""",
    classifiers=[],  # Get strings from http://pypi.python.org/pypi?%3Aaction=list_classifiers
    include_package_data=True,
    keywords='',
    author='Michael Sarfati',
    author_email='michael.sarfati@utoronto.ca',
    # url='http://',
    # dependency_links=[
    #     ('https://github.com/iandennismiller/Flask-Diamond/archive/'
    #         '{ver}.tar.gz#egg=flask_diamond-{ver}').format(ver=diamond_version),
    # ],
    install_requires=[
        "Flask==0.10.1",
        "Flask-Script==2.0.5",
        # "Sphinx==1.3.1",
        # "marshmallow==1.2.6",
        # "pysqlite==2.6.3",
    ],
    license='MIT',
    zip_safe=False,
)
