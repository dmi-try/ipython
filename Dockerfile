FROM ubuntu

MAINTAINER Dmitry Pyzhov <dpyzhov@mirantis.com>

RUN apt-get update && apt-get install -yq --no-install-recommends \
    python-virtualenv python-dev gcc g++ libffi-dev libssl-dev \
    libfreetype6-dev libpng12-dev pkg-config python-pip

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -yq --no-install-recommends \
    python-setuptools

RUN apt-get update && apt-get install -yq --no-install-recommends \
    cython

COPY requirements.txt /tmp/

RUN pip install -r /tmp/requirements.txt && rm /tmp/requirements.txt

COPY notebooks /root/notebooks/

CMD cd /root/notebooks && /usr/local/bin/jupyter notebook --ip=0.0.0.0 --no-browser $*

EXPOSE 8888
