#!/bin/sh
MOD_PKG_NAME=functions
PROJECT_ID=onua-246719
SOURCE_VERSION=v0.24.0
DEPLOY_PATH=customer-app-deploy
HOME=$(pwd)
FUNCTION_PATH=customer-app/functions
mkdir $DEPLOY_PATH
cd $DEPLOY_PATH
git clone https://github.com/albertowusuasare/customer-app.git
cd ./$FUNCTION_PATH
git checkout $SOURCE_VERSION
$HOME/$DEPLOY_PATH/customer-app/script/gomod.sh $MOD_PKG_NAME
gcloud functions deploy customer-svc-func-gcp --entry-point Handle --runtime go111 --trigger-http --set-env-vars PROJECT_ID=$PROJECT_ID
cd $HOME
rm -rf $DEPLOY_PATH
rm -rf Library