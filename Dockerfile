FROM circleci/node:10

MAINTAINER Yanuar Affandy

# variable "HELM_VERSION" must be passed as docker environment variables during the image build
# docker build --no-cache --build-arg HELM_VERSION=2.12.0 -t alpine/helm:2.12.0 .
ARG HELM_VERSION

ENV BASE_URL="https://storage.googleapis.com/kubernetes-helm"
ENV TAR_FILE="helm-v${HELM_VERSION}-linux-amd64.tar.gz"

RUN sudo apt-get update && \
    sudo apt-get install python-pip python-dev jq && \
    sudo apt-get install -yq --no-install-recommends \
         curl libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
         libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
         libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 \
         libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
         libnss3 && \
    sudo rm -rf /var/lib/apt/lists/*

RUN sudo npm install -g serverless npm@latest
RUN sudo pip install awscli

RUN sudo curl -L ${BASE_URL}/${TAR_FILE} | sudo tar xvz
RUN sudo mv linux-amd64/helm /usr/bin/helm
RUN sudo chmod +x /usr/bin/helm