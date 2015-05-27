FROM rails:4.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
ENV APP_HOME /var/app
ADD . $APP_HOME
WORKDIR $APP_HOME
RUN bundle install