#!/bin/bash

app_name=$1

function create_rails_app() {
  rails new ~/src/rails/$app_name --force --database=postgresql --skip-bundle
  cp database.yml ~/src/rails/$app_name/config/
  cp docker-compose.yml ~/src/rails/$app_name/
  cp Dockerfile ~/src/rails/$app_name/

  cd ~/src/rails/$app_name/
  sed -i "s/^# gem 'therubyracer'/gem 'therubyracer'/" Gemfile

  echo "Rails app created in ~/src/rails/$app_name"
}

if [ -n "$app_name" ]; then
  create_rails_app
else
  echo "USAGE: init.sh <app_name>"
fi
