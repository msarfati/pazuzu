#!/usr/bin/env bash
COOKIEJAR='/tmp/cookiejar'
curl -c $COOKIEJAR http://127.0.0.1:5000/user/joe && cat $COOKIEJAR
