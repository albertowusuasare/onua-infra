#!/bin/sh
MOD_PKG_NAME=functions
PROJECT_ID=onua-246719
SOURCE_VERSION=v0.9.0
ARTIFACT_NAME="customer_svs_function_$SOURCE_VERSION.zip"
DEPLOY_PATH=customer-app-deploy
HOME=$(pwd)
FUNCTION_PATH=customer-app/functions
CLOUD_STORAGE_PATH="gs://onua-service-artifacts/customer-svs/$ARTIFACT_NAME"
mkdir $DEPLOY_PATH
cd $DEPLOY_PATH
git clone https://github.com/albertowusuasare/customer-app.git
cd ./$FUNCTION_PATH
git checkout $SOURCE_VERSION
$HOME/$DEPLOY_PATH/customer-app/script/gomod.sh $MOD_PKG_NAME
gcloud functions deploy customer-svc-func --entry-point Handle --runtime go111 --trigger-http --source $CLOUD_STORAGE_PATH  --project $PROJECT_ID --set-env-vars PROJECT_ID=$PROJECT_ID
cd $HOME
rm -rf $DEPLOY_PATH
rm -rf Library