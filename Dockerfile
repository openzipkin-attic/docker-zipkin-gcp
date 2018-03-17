#
# Copyright 2018 The OpenZipkin Authors
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
FROM openzipkin/zipkin:2.6.0
MAINTAINER OpenZipkin "http://zipkin.io/"

ENV ZIPKIN_GCP_REPO https://jcenter.bintray.com
ENV ZIPKIN_GCP_VERSION 0.1.1
# Readback is currently not supported
ENV QUERY_ENABLED false

RUN apk add unzip && \ 
  curl -SL $ZIPKIN_GCP_REPO/io/zipkin/gcp/zipkin-autoconfigure-storage-stackdriver/$ZIPKIN_GCP_VERSION/zipkin-autoconfigure-storage-stackdriver-$ZIPKIN_GCP_VERSION-module.jar > stackdriver.jar && \
  echo > .stackdriver_profile && \
  unzip stackdriver.jar -d stackdriver && \
  rm stackdriver.jar && \
  apk del unzip

CMD test -n "$STORAGE_TYPE" && source .${STORAGE_TYPE}_profile; java ${JAVA_OPTS} -Dloader.path=stackdriver -Dspring.profiles.active=stackdriver -cp . org.springframework.boot.loader.PropertiesLauncher
