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
FROM openzipkin/zipkin:2.11.5
MAINTAINER OpenZipkin "http://zipkin.io/"

ENV ZIPKIN_GCP_REPO https://jcenter.bintray.com
ENV ZIPKIN_GCP_VERSION 0.8.1
# Readback is currently not supported
ENV QUERY_ENABLED false
# must match JRE, in this case zipkin:2.11.1 uses 1.8.0_171
# see https://github.com/square/okhttp/blob/master/pom.xml for example mappings
# this and the download of alpn-boot will be removed with https://github.com/openzipkin/docker-jre-full/issues/9
ENV ALPN_VERSION 8.1.12.v20180117

RUN apk add unzip && \ 
  curl -SL $ZIPKIN_GCP_REPO/org/mortbay/jetty/alpn/alpn-boot/$ALPN_VERSION/alpn-boot-$ALPN_VERSION.jar > alpn-boot.jar && \
  curl -SL $ZIPKIN_GCP_REPO/io/zipkin/gcp/zipkin-autoconfigure-storage-stackdriver/$ZIPKIN_GCP_VERSION/zipkin-autoconfigure-storage-stackdriver-$ZIPKIN_GCP_VERSION-module.jar > stackdriver.jar && \
  echo > .stackdriver_profile && \
  unzip stackdriver.jar -d stackdriver && \
  rm stackdriver.jar && \
  apk del unzip

CMD test -n "$STORAGE_TYPE" && source .${STORAGE_TYPE}_profile; java ${JAVA_OPTS} -Dloader.path=stackdriver -Dspring.profiles.active=stackdriver -Xbootclasspath/p:alpn-boot.jar -cp . org.springframework.boot.loader.PropertiesLauncher
