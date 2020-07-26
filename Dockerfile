FROM ruby:alpine

RUN apk add --no-cache --update build-base

RUN gem install rspec rake

COPY . /app
WORKDIR /app

#CMD irb
