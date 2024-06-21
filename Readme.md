# Airflow Git Runner

Airflow Git Runner is a project that allows you to download a Git repository, install the requirements and run Apache Airflow, by default in standalone mode.

This way you avoid the need to compile a custom image for airflow execution.

- Supports ssh cloning of SSH repositories by copying the private key to /home/airflow/.ssh/id_rsa

## Use

```yaml
version: '3'
services:
  airflowgit:
    image: ymil/airflow-git:latest
    ports:
      - "8080:8080"
    volumes:
      # SHARE ID_RSA TO DOCKER
      - $PWD/.ssh/id_rsa:/.ssh/id_rsa

      # PERSISTENT REQUIREMENTS INSTALL
      - python:/home/airflow/.local/lib/python3.8
    environment:
      - GIT_REPO= # COMPLETE
      - GIT_BRANCH="main"
      - DAGS_PATH="dags"
      - REQUIREMENTS_PATH="requirements.txt"
      - AIRFLOW_CONFIG_PATH="airflow.cfg"

volumes:
  python:
```

## Example GIT_REPO structure

- /dags: Code for run in airflow with dag.py
- requirements.txt: requirements for install in docker for run project.
- airflow.cfg: settings for run airflow

## Dockerhub

https://hub.docker.com/r/ymil/airflow-git
