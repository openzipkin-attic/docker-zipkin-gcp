# docker-zipkin-gcp

## Archived

This repository is archived as it has been folded into https://github.com/openzipkin/zipkin-gcp/tree/master/docker

## Overview

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
