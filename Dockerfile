#
# Based on https://hub.docker.com/r/dalibo/pgtap/dockerfile
#
FROM postgres:12.4

RUN apt-get update && apt-get install -y \
  # Builds utils
  build-essential \
  gettext-base \
  git-core \
  curl \
  # required by pgtap
  libv8-dev \
  postgresql-server-dev-12 \ 
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# install pg_prove
RUN curl -LO http://xrl.us/cpanm \
  && chmod +x cpanm \
  && ./cpanm TAP::Parser::SourceHandler::pgTAP

# install pgtap
RUN git clone git://github.com/theory/pgtap.git \
  && cd pgtap \
  && make \
  && make install \
  && make clean

RUN mkdir -p tests
COPY test.sql tests/.
