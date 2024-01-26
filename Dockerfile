FROM apache/airflow:latest

USER root

RUN apt update && apt install git --yes

ENV AIRFLOW_HOME=/opt/airflow

RUN mkdir -p $AIRFLOW_HOME && chown airflow:root $AIRFLOW_HOME

WORKDIR $AIRFLOW_HOME

USER airflow

ENV GIT_REPO=
ENV GIT_BRANCH=

# PATH RELATIVE FROM REPOSITORY
ENV DAGS_PATH=dags
ENV REQUIREMENTS_PATH=requirements.txt
ENV AIRFLOW_CONFIG_PATH=airflow.cfg

RUN mkdir /home/airflow/.ssh

COPY entrypoint-git.sh /entrypoint-git.sh
ENTRYPOINT [ "/entrypoint-git.sh" ]
CMD [ "standalone" ]