# cromwell-bayesian-model-covid-demo

To execute:
 
 1. download https://github.com/broadinstitute/cromwell/releases/download/84/cromwell-84.jar to the project directory
 2. docker pull python
 3. edit idmWorkflow.wdl using a text editor to specify the run paramters (lines 39-42)
	        state = "PA",
	        start_date = "2020-03-05",
	        end_date = "2020-03-07"
 4. java -jar cromwell-84.jar run idmWorkflow.wdl

