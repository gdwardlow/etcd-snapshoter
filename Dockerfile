FROM quay.io/coreos/etcd

RUN apk add --update \
  bash \
  ca-certificates \
  curl \
  gcc \
  jq \
  libffi-dev \
  libressl-dev \
  linux-headers \
  musl-dev \
  py-pip \
  py-setuptools \
  python-dev \
  && pip install --no-cache-dir pip setuptools \
  && pip install --no-cache-dir python-openstackclient==3.12.0 \
  && pip install --no-cache-dir python-neutronclient==6.5.0  \
  && pip install --no-cache-dir python-designateclient==2.7.0 \
  && pip install --no-cache-dir swiftly==2.06 \
  && pip install --no-cache-dir python-octaviaclient==1.1.0 \
  && apk del gcc libffi-dev libressl-dev linux-headers musl-dev \
  && rm -rf /var/cache/apk/*

ADD snap.sh /usr/local/bin/snap.sh

# Add a volume so that a host filesystem can be mounted .
# e.g. docker run -v ${PWD}:/data quay.io/rackspace/openstack-cli
#VOLUME ["/data"]

ENV PS1="\W $ "

# Default is to start a shell. A more common behavior would be to override the command when starting.
# e.g. docker run --rm -it quay.io/rackspace/openstack-cli openstack server list
CMD ["/bin/bash"]
