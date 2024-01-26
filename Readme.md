# Airflow Git Runner

Airflow Git Runner es un proyecto que permite descargar un repositorio de Git, instalar los requisitos y ejecutar Apache Airflow, por defecto en modo standalone.

De esta manera evitar la necesidad de compilar una imagen custom para para ejecución de airflow.

- Soporta clonado ssh de repositorios SSH copiando la clave privada a /home/airflow/.ssh/id_rsa

## Uso

```
version: '3'
services:
  airflowgit:
    image: ymil/airflow-git:latest
    ports:
      - "8080:8080"
    volumes:
      - $PWD/id_rsa:/home/airflow/.ssh/id_rsa
    environment:
      - GIT_REPO=
      - GIT_BRANCH=
      - AIRFLOW_CONFIG_PATH=
```

## Dockerhub

https://hub.docker.com/r/ymil/airflow-git