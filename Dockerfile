# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.3.4
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

WORKDIR /ip_geolocation_api

ENV IPSTACK_KEY="a9ce77efa9c4f2a62ca4d4179c1a1e5a"

FROM base

COPY Gemfile* /ip_geolocation_api/

# Install packages needed to build gems
RUN apt-get update -qq && \
apt-get install --no-install-recommends -y build-essential git libpq-dev curl libvips postgresql-client pkg-config

RUN gem install bundler -v 2.5.15
RUN gem install rails

COPY . .
RUN bundle install

EXPOSE 3000

RUN touch $HOME/.bashrc
RUN echo "alias ll='ls -alF'" >> $HOME/.bashrc
RUN echo "alias la='ls -A'" >> $HOME/.bashrc
RUN echo "alias l='ls -CF'" >> $HOME/.bashrc
RUN echo "alias q='exit'" >> $HOME/.bashrc
RUN echo "alias c='clear'" >> $HOME/.bashrc

# ENTRYPOINT [ "/bin/bash" ]

LABEL author="Rafael E Massu S"
LABEL version="0.0.1"
LABEL description="IP Geolocation API Rails app"

# Entrypoint prepares the database.
ENTRYPOINT ["/ip_geolocation_api/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
# CMD ["./bin/rails", "server"]
