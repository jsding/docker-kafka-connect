docker-kafka-connect
### with Docker CLI

```shell
$ docker run --rm --name connect \
    -p 8083:8083 \
    -e CONNECT_BOOTSTRAP_SERVERS=kafka:9092 \
    -e CONNECT_GROUP_ID=connect-cluster-A \
    --link kafka:kafka dbface/kafka-connect
```

## Environment Variables

Pass env variables starting with `CONNECT_` to configure `connect-distributed.properties`.  
For example, If you want to set `offset.flush.interval.ms=15000`, use `CONNECT_OFFSET_FLUSH_INTERVAL_MS=15000`

- (**required**) `CONNECT_BOOTSTRAP_SERVERS`
- (*recommended*): `CONNECT_GROUP_ID` (default value: `connect-cluster`) 
- (*recommended*) `CONNECT_REST_ADVERTISED_HOST_NAME`
- (*recommended*) `CONNECT_REST_ADVERTISED_PORT`

Other connect configuration fields are optional. (see also [Kafka Connect Configs](http://kafka.apache.org/documentation.html#connectconfigs))

## How To Extend This Image

If you want to run additional connectors, add connector JARs to `${KAFKA_HOME}/connectors` in container.

```
FROM 1ambda/kafka-connect:latest

# same as `cp -R connectors/ $KAFKA_HOME/`
# the entrypoint will extends `$CLASSPATH` 
# like `export CLASSPATH=${CLASSPATH}:${KAFKA_HOME}/connectors/*`

COPY connectors $KAFKA_HOME/connectors
```

## Development

- **SCALA_VERSION**: `2.11` 
- **KAFKA_VERSION**: `0.10.0.0`
- **KAFKA_HOME**: `/opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}`
- **CONNECT_CFG**: `${KAFKA_HOME}/config/connect-distributed.properties`
- **CONNECT_BIN**: `${KAFKA_HOME}/bin/connect-distributed.sh`
- **CONNECT_PORT**: `8083` (exposed)
- **JMX_PORT**: `9999` (exposed)
 
# License

Apache 2.0
