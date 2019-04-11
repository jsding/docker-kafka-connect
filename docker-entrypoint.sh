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

JOB_CFG=${KAFKA_HOME}/connectors/${job}.properties

info "Execute JOB: ${JOB_CFG}"

exec "$@"
