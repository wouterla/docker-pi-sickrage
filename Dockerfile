FROM hypriot/rpi-alpine-scratch:latest
MAINTAINER Wouter Lagerweij <wouter@lagerweij.com>

ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    TERM='xterm'

RUN apk update && \
    apk -U upgrade && \
    apk -U add \
        ca-certificates \
        py-pip ca-certificates git python py-libxml2 libxml2-dev libxslt-dev \
        make gcc g++ python-dev openssl-dev libffi-dev unrar \
        && \
    pip --no-cache-dir install lxml pyopenssl cheetah requirements && \
    git clone --depth 1 https://github.com/SickRage/SickRage.git /sickrage && \
    apk del make gcc g++ python-dev && \
    rm -rf /tmp && \
    rm -rf /var/cache/apk/*

VOLUME ["/config", "/data", "/cache", "/scripts"]

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 8081

CMD ["/start.sh"]
