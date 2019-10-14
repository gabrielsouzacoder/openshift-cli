FROM       ubuntu:16.04
MAINTAINER Jonathan Nagayoshi "https://github.com/sonikro"

ENV OC_VERSION "v3.11.0"
ENV OC_RELEASE "openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit"

## Init
RUN apt-get update

## Install OC Library
RUN apt-get install -y wget
RUN mkdir -p /opt/oc
RUN wget -O /opt/oc/release.tar.gz https://github.com/openshift/origin/releases/download/$OC_VERSION/$OC_RELEASE.tar.gz 
RUN apt-get install ca-certificates
RUN tar --strip-components=1 -xzvf  /opt/oc/release.tar.gz -C /opt/oc/ && \
    mv /opt/oc/oc /usr/bin/ && \
    rm -rf /opt/oc
RUN cp /usr/bin/oc /bin/oc
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT [ "docker-entrypoint.sh" ]