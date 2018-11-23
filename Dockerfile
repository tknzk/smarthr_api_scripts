FROM ruby:2.6.0-preview3

ENV LC_ALL=C.UTF-8 \
  LANG=en_US.UTF-8 \
  LANGUAGE=en_US.UTF-8

WORKDIR /app

COPY . /app

RUN \
  apt-get update -qq \
  && gem install bundler --pre \
  && bundle install --jobs 2 --path /bundle --no-cache
