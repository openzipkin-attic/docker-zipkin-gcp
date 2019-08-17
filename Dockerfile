#
# Copyright 2018-2019 The OpenZipkin Authors
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
# in compliance with the License. You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License
# is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
# or implied. See the License for the specific language governing permissions and limitations under
# the License.
#

FROM alpine

WORKDIR /zipkin-gcp

ENV ZIPKIN_GCP_REPO https://repo1.maven.org/maven2
ENV ZIPKIN_GCP_VERSION 0.13.4

RUN apk add curl unzip && \
  curl -SL $ZIPKIN_GCP_REPO/io/zipkin/gcp/zipkin-autoconfigure-storage-stackdriver/$ZIPKIN_GCP_VERSION/zipkin-autoconfigure-storage-stackdriver-$ZIPKIN_GCP_VERSION-module.jar > stackdriver.jar && \
  echo > .stackdriver_profile && \
  unzip stackdriver.jar -d stackdriver && \
  rm stackdriver.jar

FROM openzipkin/zipkin:2.16.1
MAINTAINER OpenZipkin "https://zipkin.io/"

COPY --from=0 /zipkin-gcp/ /zipkin/

# Readback is currently not supported
ENV QUERY_ENABLED false

env MODULE_OPTS="-Dloader.path=stackdriver -Dspring.profiles.active=stackdriver"
