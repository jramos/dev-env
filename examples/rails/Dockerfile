FROM ruby:2.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

ENV APP_HOME /var/www
ADD . $APP_HOME

WORKDIR $APP_HOME
RUN bundle install
