#!/bin/sh
# see https://medium.com/@pliutau/google-cloud-functions-in-go-56f5ef3f9b55
export GO111MODULE=on
DEPLOY_PATH=customer-app-deploy
HOME=$(pwd)
echo $HOME
mkdir $DEPLOY_PATH
cd $DEPLOY_PATH
git clone https://github.com/albertowusuasare/customer-app.git
cd ./customer-app/cmd/customer-svc-func/google
go mod init
go mod tidy
go mod vendor
gcloud functions deploy google --entry-point Handle --runtime go111 --trigger-http --set-env-vars PROJECT_ID=onua-246719
cd $HOME
rm -rf $DEPLOY_PATH
rm -rf Library
