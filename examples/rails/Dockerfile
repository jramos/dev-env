FROM ruby:2.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

ENV APP_HOME /var/app
ADD . $APP_HOME
RUN chmod -R www-data:www-data $APP_HOME

USER www-data
WORKDIR $APP_HOME
RUN bundle install
RUN bundle exec rake db:create db:migrate
