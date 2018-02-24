[![Build Status](https://travis-ci.org/openzipkin/docker-zipkin-gcp.svg)](https://travis-ci.org/openzipkin/docker-zipkin-gcp)
[![zipkin-gcp](https://quay.io/repository/openzipkin/zipkin-gcp/status "zipkin-gcp")](https://quay.io/repository/openzipkin/zipkin-gcp)

# docker-zipkin-gcp

This repository contains the Docker build definition and release process for
[openzipkin/zipkin-gcp](https://github.com/openzipkin/zipkin-gcp).

This layers Google Cloud Platform support on the base [zipkin docker image](https://github.com/openzipkin/docker-zipkin).

Currently, this adds Stackdriver Trace storage

## Running

By default, this image will search for credentials in a json file at `$GOOGLE_APPLICATION_CREDENTIALS`

If you want to try Zipkin against Stackdriver, the easiest start is to share
your credentials with Zipkin's docker image.

```bash
$ docker run -d -p 9411:9411 \
  -e STORAGE_TYPE=stackdriver \
  -e GOOGLE_APPLICATION_CREDENTIALS=/root/.gcp/credentials.json \
  -e STACKDRIVER_PROJECT_ID=your_project \
  -v $HOME/.gcp:/root/.gcp:ro \
  openzipkin/zipkin-gcp
```

## Configuration

Configuration is via environment variables, defined by [zipkin-gcp](https://github.com/openzipkin/zipkin-gcp/blob/master/README.md).

In docker, the following can also be set:

    * `JAVA_OPTS`: Use to set java arguments, such as heap size or trust store location.

### Stackdriver

Stackdriver Configuration variables are detailed [here](https://github.com/openzipkin/zipkin-gcp/tree/master/autoconfigure/storage-stackdriver#configuration).
