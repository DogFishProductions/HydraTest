#!/bin/ash

# If we run source ~/.profile it will be looking for this file on the host and won't find it!!
# That's why we're using a shell script - it uses the correct scope (i.e. the container).
# We're running this script so that npm can find the directories we need to overcome install permission issues.
source ~/.profile

if [ -d "/home/dogfish/app/hello-service" ]; then
  cd hello-service
  npm install
  if [ $1 = "production" ]; then
    echo "we're in production"
    NODE_ENV=$1 npm start
  else 
    if [ $1 = "test" ]; then
      echo "running tests"
      NODE_ENV=$1 npm test
    else
      echo "we're in $1"
      NODE_ENV=$1 npm start
    fi
  fi
fi