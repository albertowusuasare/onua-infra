## Deployment Flow

Each app has its own dedicated folder. The app folder structure is as follows:
```
|-> app
    |-> cloud-func: for serverless cloud function deployments
    |-> kubernetes:  for kubernetes deployments
```
## Serverless deployments:
- In the cloud-func folder of the app, there is a ```deploy.sh``` script. The script should be updated to reflect the version of the function code we want to deploy. For instance to deploy version 0.0.4 for 'customer-app', 
we edit ```./customer-app/cloud-func/deploy.sh``` as follows
```shell
...

SOURCE_VERSION=0.0.4

...

```
- A pull request should be approved and then merged to develop
- In google cloud functions console, navigate to ```./<app>/cloud-func```
- Run ```deploy.sh``` for the DEV environment
- Once a checkout is done, create a release branch and update the manifest there.
- At a set period in time the release is performed
- If all goes well, merge the release branch to master.

## Deploying to Staging. 
Any commit made directly to the staging branch triggers a deployment to the staging environment. Note that only changes to an artifact version will trigger a re-deployment for that function. Thus, if an artifact version is not different from the version of the function currently running, deployment is skipped for that function. Aside triggering  deployments automatically, deployments can be triggered directly by manually running the deploy job in google cloud build. 

Events:
- commit made to staging
- deployment triggered for all funtions with new artififacts

## Cutting a release branch
To deploy the entire suite of functions to production a release branch in the form ```release/{version}``` needs to be created. When the release branch is created, an automated build begins. The build deploys the versions of all the suite of functions available, using their respective artifact versions. After a succesful deployment, end-to-end (e2e) tests are run for that release and the test results are uploaded to a cloud storage location. Upon a successful completion of e2e tests, a pull request is submitted against master

Events:
- release branch created
- deployment triggered for all functions
- e2e tests run
- e2e test uploaded to cloud storage
- pull request created


## Deploying to production 
To deploy to product, the pull request is verified (see Production Pull Request Verification) and then merged to master. Upon merging the release branch to master, a deployment to production is triggered. After a successuful deploy, a tag is created to increment the semantic version of deployment project. The release branch is deleted.

- pull request verified
- release branch merged
- deployment triggered
- semantic version updated. 
