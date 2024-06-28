#!/usr/bin/env -S just --justfile

[group('setup')]
setup-dev-env: create-env install-dev-requirements

create-env:
    python3 -m venv .env

activate-env:
    source .env/bin/activate

[group('install')]
install-dev-requirements: activate-env
    python3 -m pip --require-virtualenv install --requirement requirements.dev

[group('format')]
format: format-python

[group('format')]
format-python:
    black **/*.py

[group('check-format')]
check-format: check-python-format

[group('check-format')]
check-python-format:
    black --check --diff **/*.py

[group('lint')]
lint: lint-yaml lint-markdown

[group('lint')]
lint-yaml:
    yamllint -c .yamllint.yaml .

[group('lint')]
lint-markdown:
    pymarkdown scan .
