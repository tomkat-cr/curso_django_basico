SHELL := /bin/bash

PYTHON_VERSION = 3.9

# General Commands
help:
	cat Makefile

# Automated Testing
test: venv_run
	pip${PYTHON_VERSION} install pytest coverage ;
	python${PYTHON_VERSION} -m pytest ;
	deactivate ;

# Formatting
lint:
	pipenv run prospector

types:
	pipenv run mypy .

coverage:
	pipenv run coverage run -m unittest discover tests;
	pipenv run coverage report

format:
	pipenv run yapf -i *.py **/*.py **/**/*.py

format_check:
	pipenv run yapf --diff *.py **/*.py **/**/*.py

pycodestyle:
	pycodestyle *.py **/*.py **/**/*.py

qa: lint types tests format_check pycodestyle

# Development Commands
venv_run:
	. run_app.sh venv

install:
	pip install -r requirements.txt

fresh:
	rm -rf venv
	. run_app.sh venv
	pip${PYTHON_VERSION} install --upgrade pip
	pip${PYTHON_VERSION} install django
	pip${PYTHON_VERSION} install prospector
	pip${PYTHON_VERSION} install yapf
	# pip${PYTHON_VERSION} install wheel
	pip${PYTHON_VERSION} freeze >> requirements.txt

requirements:
	pip${PYTHON_VERSION} freeze >> requirements.txt

makemigrations:
	sh run_app.sh makemigrations

migrate:
	sh run_app.sh migrate

shell:
	sh run_app.sh shell

createsuperuser:
	sh run_app.sh createsuperuser

# Application execution
run:
	sh run_app.sh runserver

