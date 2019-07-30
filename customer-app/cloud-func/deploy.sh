#!/bin/sh
export GO111MODULE=on
SOURCE_VERSION=v0.0.4
DEPLOY_PATH=customer-app-deploy
HOME=$(pwd)
echo $HOME
mkdir $DEPLOY_PATH
cd $DEPLOY_PATH
git clone https://github.com/albertowusuasare/customer-app.git
cd ./customer-app/cmd/customer-svc-func/google
git checkout $SOURCE_VERSION
go mod init
go mod tidy
go mod vendor
gcloud functions deploy google --entry-point Handle --runtime go111 --trigger-http --set-env-vars PROJECT_ID=onua-246719
cd $HOME
rm -rf $DEPLOY_PATH
rm -rf Library
