FROM ruby:2.6.3

ENV APP_PATH /probanap
ENV USER probanap

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn

RUN adduser --disabled-password --gecos '' $USER
USER $USER
WORKDIR $APP_PATH

COPY Gemfile* $APP_PATH/

RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3

#COPY package.json yarn.lock $APP_PATH/

#RUN yarn install --check-files

COPY . $APP_PATH

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
