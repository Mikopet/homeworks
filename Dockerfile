FROM ruby:2.7.1-alpine

RUN apk add --no-cache --update build-base postgresql-dev tzdata less

ENV USER shapr
ENV APP_PATH /app
WORKDIR $APP_PATH

RUN adduser -D $USER
USER $USER

COPY Gemfile* $APP_PATH/

RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3

COPY . $APP_PATH

ENV RUBYOPT='-W0'

CMD puma
