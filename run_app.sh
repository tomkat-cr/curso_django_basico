#!/bin/sh
APP_DIR="premiosplatziapp"
PYTHON_VERSION="3.9"

DJANGO_CMD="$1"
if [ "${DJANGO_CMD}" = "" ]; then
    DJANGO_CMD="runserver"
fi

python${PYTHON_VERSION} -m venv venv ;
source venv/bin/activate ;

if [ "${DJANGO_CMD}" != "venv" ]; then
    cd "${APP_DIR}"
    python${PYTHON_VERSION} manage.py runserver
fi
