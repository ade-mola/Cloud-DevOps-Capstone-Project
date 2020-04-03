## The Makefile includes instructions on environment setup and lint tests
# Create and activate a venv
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint
# app.py should pass pylint

setup:
	# Create python venv & source it
	apt-get -y install python3-venv
	python3 -m venv ~/.devops
	source ~/.devops/bin/activate

install:
	# This should be run from inside a venv
	pip install --upgrade pip &&\
		pip install -r requirements.txt

test:
	# Additional, optional tests
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

lint:
	# This is linter for Dockerfile
	hadolint Dockerfile
	# This a linter for python code and should be run from venv
	pylint --disable=R,C,W1203 app.py

all: install lint test