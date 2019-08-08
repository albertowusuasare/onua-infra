#!/bin/sh
export GO111MODULE=on
SOURCE_VERSION=v0.1.2
DEPLOY_PATH=customer-app-deploy
HOME=$(pwd)
FUNCTION_PATH=customer-app/cmd/customer-svc-func-gcp
mkdir $DEPLOY_PATH
cd $DEPLOY_PATH
git clone https://github.com/albertowusuasare/customer-app.git
cd ./$FUNCTION_PATH
git checkout $SOURCE_VERSION
go mod tidy
go mod vendor
gcloud functions deploy customer-svc-func-gcp --entry-point Handle --runtime go111 --trigger-http --set-env-vars PROJECT_ID=onua-246719
cd $HOME
rm -rf $DEPLOY_PATH
rm -rf Library
