FROM ruby:3.0.0-alpine

ARG APP_PATH=/app
ARG USER=app
ENV RUBYOPT='-W0'

RUN adduser -D $USER
WORKDIR $APP_PATH

RUN apk add --no-cache --update bash build-base postgresql-dev tzdata less

USER $USER

#COPY Gemfile* $APP_PATH/
#
#RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3
#
#COPY . $APP_PATH
#
#EXPOSE 3000
#
## Start the main process.
#CMD ["rails", "server", "-b", "0.0.0.0"]
#
