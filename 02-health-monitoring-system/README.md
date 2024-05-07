# Health Monitoring System

This monitoring system is designed to do a basic health check for any given API based on its configuration provided by the user.


## High level design
![Copy of Health Monitoring system](https://github.com/Pravin-Subramanian21/hyperverge-assignment/assets/90493442/2a900e59-92b9-4cc5-809f-85571631d9ed)

* The system contains a Kubernetes cronjob that is deployed at regular intervals based on the user configuration. 
* The cronjob bundles with the docker image that contains a python app that will hit the respective API endpoint and validates the response.
* If the response returned is not successful, an email alert is triggered to the respective ID which is configured for alerting.
* This above process is repeated again at regular intervals based on the cron timings.

## Steps required to re-create the environment
* Create a new cronjob with the required API endpoint and its related configuration under deployment.
* Deploy it into an Kubernetes cluster.

## Output
Below represents the Alert Email that was received  when the configured API endpoint was down.

![Screenshot 2024-05-07 at 7 21 20 PM](https://github.com/Pravin-Subramanian21/hyperverge-assignment/assets/90493442/54edd36c-c984-442f-865c-314bc450d7b8)