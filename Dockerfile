FROM ruby:latest

ENV APP_PATH /probanap
ENV USER probanap

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

RUN adduser --disabled-password --gecos '' $USER
USER $USER
WORKDIR $APP_PATH

COPY Gemfile* $APP_PATH/

RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3
COPY . $APP_PATH

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
