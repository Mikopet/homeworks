FROM ruby:2.7.1-alpine

ENV APP_PATH /app
WORKDIR $APP_PATH

COPY Gemfile* $APP_PATH/

RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3

COPY . $APP_PATH

ENV RUBYOPT='-W0'

CMD rspec
