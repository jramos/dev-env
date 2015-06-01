#!/bin/bash

app_name=$1
app_root=~/src/rails/$app_name

function create_rails_app() {
  rails new $app_root --force --database=postgresql --skip-bundle
  cp -r config/* $app_root/config/
  cp docker-compose.yml $app_root/
  cp Dockerfile $app_root/
  cp Gemfile $app_root/
  cd $app_root
  bundle install
}

if [ -n "$app_name" ]; then
  create_rails_app
  echo "Rails app created in $app_root"
else
  echo "USAGE: ./create.sh <app_name>"
fi
