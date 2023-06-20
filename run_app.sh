#!/bin/sh
APP_DIR="premiosplatziapp"

DJANGO_CMD="$1"
if [ "${DJANGO_CMD}" = "" ]; then
    DJANGO_CMD="runserver"
fi

python3 -m venv venv ;
source venv/bin/activate ;
# pip install -r requirements.txt ;

cd "${APP_DIR}"
python3 manage.py runserver
