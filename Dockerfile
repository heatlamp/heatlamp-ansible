FROM heatlamp/core
MAINTAINER Ash Wilson <smashwilson@gmail.com>

RUN apt-get install -y python-dev python-pip
RUN /usr/bin/pip install ansible

ENV HEATLAMP_SCRIPT /usr/src/app/triggered.sh

ADD triggered.sh /usr/src/app/triggered.sh
