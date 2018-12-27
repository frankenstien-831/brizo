FROM python:3.6-alpine
LABEL maintainer="Ocean Protocol <devops@oceanprotocol.com>"

ARG VERSION

RUN apk add --no-cache --update\
    build-base \
    gcc \
    gettext\
    gmp \
    gmp-dev \
    libffi-dev \
    openssl-dev \
    py-pip \
    python3 \
    python3-dev \
  && pip install virtualenv

COPY . /brizo
WORKDIR /brizo

RUN pip install -r requirements_dev.txt

# config.ini configuration file variables
ENV KEEPER_URL='http://127.0.0.1:8545'
ENV SECRET_STORE_URL='http://127.0.0.1:12001'
ENV PARITY_ADDRESS=''
ENV PARITY_PASSWORD=''

ENV AZURE_ACCOUNT_NAME=''
ENV AZURE_ACCOUNT_KEY=''
ENV AZURE_RESOURCE_GROUP=''
ENV AZURE_LOCATION='westus'
ENV AZURE_CLIENT_ID=''
ENV AZURE_CLIENT_SECRET=''
ENV AZURE_TENANT_ID=''
ENV AZURE_SUBSCRIPTION_ID=''
ENV AZURE_SHARE_INPUT='compute'
ENV AZURE_SHARE_OUTPUT='output'

ENV BRIZO_URL='http://0.0.0.0:8030'

# docker-entrypoint.sh configuration file variables
ENV BRIZO_WORKERS='1'

ENTRYPOINT ["/brizo/docker-entrypoint.sh"]

EXPOSE 8030
