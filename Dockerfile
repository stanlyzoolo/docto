FROM python:3.9
# Create group and user. Add the user to the group
RUN useradd -ms /bin/bash appuser
RUN groupadd appusers && usermod -aG appusers appuser
RUN  newgrp appusers
USER appuser
# Envs
ENV PYTHONDONTWRITEBYCODE 1
ENV PYTHONUNBUFFERED 1
ENV PATH=/home/appuser/.local/bin:$PATH

RUN pip install --upgrade pip

WORKDIR /docto/

COPY --chown=appuser:appuser Pipfile Pipfile.lock /docto/

RUN pip install pipenv && pipenv install --system

COPY . /docto/

EXPOSE 8000