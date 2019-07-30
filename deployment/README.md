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

