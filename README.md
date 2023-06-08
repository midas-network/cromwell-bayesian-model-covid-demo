# cromwell-bayesian-model-covid-demo

This project demostrates running the Bayesian model using Cromwell, Python, and Docker.

## To execute:
 
 1. download https://github.com/broadinstitute/cromwell/releases/download/84/cromwell-84.jar to the project directory
 2. docker pull python
 3. edit idmWorkflow.wdl using a text editor to specify the run paramters (lines 39-42)
~~~
state = "PA",
start_date = "2020-03-05",
end_date = "2020-03-07"
~~~
 4. java -jar cromwell-84.jar run idmWorkflow.wdl

## Results:

Results will be inside the Docker container.  You must replace DOCKER_CONTAINER_ID with the ID of the container below to access the results:
~~~
/cromwell-bayesian-covid-model-demo/cromwell-executions/idmWorkflow/DOCKER_CONTAINER_ID/call-run_Model/execution/bayesian-covid-model-demo/scripts/results
~~~
