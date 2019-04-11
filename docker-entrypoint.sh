#!/usr/bin/env sh

tag="[docker-entrypoint.sh]"

function info {
  echo "$tag (INFO) : $1"
}
function warn {
  echo "$tag (WARN) : $1"
}
function error {
  echo "$tag (ERROR): $1"
}

set -e

# Verify envs
if [[ -z "$job" ]]; then
  error "EMPTY ENV 'job'. exit;"; exit 1
fi

# Set JMX
export KAFKA_JMX_OPTS=""

# Extend CLASSPATH for custom connectors
export CLASSPATH=${CLASSPATH}:${KAFKA_HOME}/connectors/libs/*

$JOB_CFG="${KAFKA_HOME}/connectors/${job}.properties"
info "Execute JOB: ${JOB_CFG}"

# Configure properties
echo -e "\n" >> $CONNECT_CFG
for VAR in `env`
do
  if [[ $VAR =~ ^CONNECT_ && ! $VAR =~ ^CONNECT_CFG && ! $VAR =~ ^CONNECT_BIN ]]; then
    connect_name=`echo "$VAR" | sed -r "s/CONNECT_(.*)=.*/\1/g" | tr '[:upper:]' '[:lower:]' | tr _ .`
    env_var=`echo "$VAR" | sed -r "s/(.*)=.*/\1/g"`
    if egrep -q "(^|^#)$connect_name=" $CONNECT_CFG; then
        sed -r -i "s@(^|^#)($connect_name)=(.*)@\2=${!env_var}@g" $CONNECT_CFG
    else
        echo "$connect_name=${!env_var}" >> $CONNECT_CFG
    fi
  fi
done

exec "$@"
