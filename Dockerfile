FROM apache/airflow:latest

USER root

RUN apt update && apt install git --yes

USER airflow

ENV GIT_REPO=
ENV GIT_BRANCH="main"

# PATH RELATIVE FROM REPOSITORY
ENV DAGS_PATH=dags
ENV REQUIREMENTS_PATH=requirements.txt
ENV AIRFLOW_CONFIG_PATH=airflow.cfg

COPY entrypoint-git.sh /entrypoint-git.sh
ENTRYPOINT [ "/entrypoint-git.sh" ]
CMD [ "standalone" ]