FROM heatlamp/core
MAINTAINER Ash Wilson <smashwilson@gmail.com>

RUN apt-get install -y build-essential libyaml-dev
RUN pip install ansible

ENV HEATLAMP_SCRIPT /usr/src/app/triggered.sh

ADD triggered.sh /usr/src/app/triggered.sh
