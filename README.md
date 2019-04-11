Handy way to run kafka connect.

### with Docker CLI

At host, mkdir /data/kafka/connectors
make sub directory libs and put our custom connectors jars in host directory: /data/kafka/connectors/libs
Put connector config in /data/kafka/connectors

copy the connect-distributed.properties to worker.properties and put it in /data/kafka/connectors
this will be the worker property file,
append kafaka-mongodb-sink.properties


```shell
$ docker run --name kafka-mongodb-sink-1 -p 8083:8083  -v /data/kafka/connectors:/opt/kafka_2.12-2.2.0/connectors \
    -e job=kafka-mongodb-sink \
    dbface/kafka-connect
```
this will startup kafka-mongodb-sink.properties as the JOB file

## Environment Variables

Edit the worker.properties file in docker host(/data/kafka/connectors/worker.properties)

Other connect configuration fields are optional. (see also [Kafka Connect Configs](http://kafka.apache.org/documentation.html#connectconfigs))

