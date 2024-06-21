#!/bin/bash
set -e
SSH_DIR="$HOME/.ssh"

mkdir -p $SSH_DIR;
mkdir -p $AIRFLOW_HOME 
# Si se encuentra un archivo ID_RSA se copia a la carpeta SSH
[ -e /.ssh/id_rsa ] && cp /.ssh/id_rsa $SSH_DIR/id_rsa
# Verificar si hay claves privadas en el directorio .ssh
if [ -n "ls $SSH_DIR/id_*" ]; then
    ssh-keyscan -t rsa github.com >> $SSH_DIR/known_hosts
    ssh-keyscan -t rsa gitlab.com >> $SSH_DIR/known_hosts
fi

if [ -z "${GIT_REPO}" ]; then
    echo "La variable de entorno 'GIT_REPO' no tiene un valor asignado."
    exit 1
fi

export GIT_PATH=$AIRFLOW_HOME/git

if [ ! -d $GIT_PATH ]; then
    git clone $GIT_REPO $GIT_PATH;

    cd $GIT_PATH;
    git checkout $GIT_BRANCH; 
    cd ..;
else
    cd $GIT_PATH;
    git fetch --all;
    git checkout $GIT_BRANCH;
    git pull origin $GIT_BRANCH;
    cd ..;
fi

cd $AIRFLOW_HOME;

## Si el webserver.pid existe se elimina
[ -e $AIRFLOW_HOME/airflow-webserver.pid ] && rm -rf $AIRFLOW_HOME/airflow-webserver.pid

[ -e $AIRFLOW_HOME/dags ] && rm -rf $AIRFLOW_HOME/dags
ln -fs $GIT_PATH/$DAGS_PATH $AIRFLOW_HOME/dags
ln -fs $GIT_PATH/$REQUIREMENTS_PATH
ln -fs $GIT_PATH/$AIRFLOW_CONFIG_PATH $AIRFLOW_HOME/airflow.cfg

pip install -r $REQUIREMENTS_PATH

. /entrypoint
