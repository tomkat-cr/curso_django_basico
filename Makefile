SHELL := /bin/bash

# General Commands
help:
	cat Makefile

# Automated Testing
test: venv_run
	pip install pytest coverage ;
	python -m pytest ;
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
install:
	pip install -r requirements.txt

venv_run:
	python3 -m venv venv ;
	source venv/bin/activate ;

requirements:
	pip freeze >> requirements.txt

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

