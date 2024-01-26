#!/bin/bash
set -e
ssh_dir="$HOME/.ssh"

# Verificar si hay claves privadas en el directorio .ssh
if [ -n "ls $ssh_dir/id_*" ]; then
    ssh-keyscan -t rsa github.com >> $ssh_dir/known_hosts
    ssh-keyscan -t rsa gitlab.com >> $ssh_dir/known_hosts
fi

if [ -z "${GIT_REPO}" ]; then
    echo "La variable de entorno 'GIT_REPO' no tiene un valor asignado."
    exit 1  # Puedes ajustar el código de salida según tus necesidades
fi

export GIT_PATH=$AIRFLOW_HOME/git
git clone $GIT_REPO $GIT_PATH;

if [ -n "${GIT_BRANCH}" ]; then
    (cd $GIT_PATH; git checkout $GIT_BRANCH)
fi

rm -r dags/
ln -s $GIT_PATH/$DAGS_PATH
ln -s $GIT_PATH/$REQUIREMENTS_PATH
ln -s $GIT_PATH/$AIRFLOW_CONFIG_PATH

pip install -r $REQUIREMENTS_PATH

. /entrypoint