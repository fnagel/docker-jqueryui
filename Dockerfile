ARG node_tag

FROM node:${node_tag}

# Install curl
RUN apt-get update \
    && apt-get install -y curl

# Install xsltproc
RUN apt-get update \
    && apt-get install -y xsltproc

# Install GIT
RUN apt-get update \
    && apt-get install -y git

# Install imagemagick
RUN apt-get update \
    && apt install -y --no-install-recommends libmagickwand-dev imagemagick

RUN npm install -g grunt-cli

WORKDIR /home/node

RUN curl -sL https://github.com/jquery/download.jqueryui.com/archive/master.tar.gz > archive.tar.gz \
    && tar -xzf archive.tar.gz \
    && mv download.jqueryui.com-master ./app \
    && chown -R node ./app \
    && rm archive.tar.gz

WORKDIR /home/node/app
USER node

RUN npm install

RUN grunt prepare

USER root

RUN apt-get purge -y curl build-essential \
    && apt-get --purge -y autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

USER node

RUN node -v

CMD ["node", "server.js", "--host", "0.0.0.0", "--console"]
