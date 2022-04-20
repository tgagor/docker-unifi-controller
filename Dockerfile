FROM ubuntu:20.04
MAINTAINER Tomasz Gągor

ENV DEBIAN_FRONTEND=noninteractive \
    JAVA_OPTS="-Xmx256M"

VOLUME /tmp /var/cache/apt /var/lib/apt/lists /var/tmp /root/.cache

RUN apt-get update && \
    apt-get install -y ca-certificates apt-transport-https && \
    echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | tee /etc/apt/sources.list.d/unifi.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv 06E85760C0A52C50 && \
    apt-get update && \
    apt-mark hold openjdk-11-* && \
    apt-get install -y openjdk-8-jre unifi
    
VOLUME /usr/lib/unifi/data

EXPOSE 8443/tcp 8080/tcp 8843/tcp 8880/tcp 3478/udp 10001/udp

WORKDIR /usr/lib/unifi

CMD java $JAVA_OPTS -jar /usr/lib/unifi/lib/ace.jar start
