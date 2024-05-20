# cromwell-bayesian-model-covid

This project demostrates running a Bayesian Covid model using Cromwell, Python, and Docker.

## Cromwell:
[Cromwell](https://github.com/broadinstitute/cromwell) is an open-source Workflow Management System for bioinformatics.

## Model:
[Bayesian compartmental models for COVID-19](https://github.com/midas-network/bayesian-covid-model-demo.git): This repository contains code for Bayesian estimation of compartmental models for COVID-19 using python, numpyro and jax.

## Execution:
### Pre-requisites:
 
 1. JAVA must be installed and be a minimum version of 11.
 2. Docker must also be installed and running.

Please note: The cromwell workflow script will check for these requirements and stop execution if they are not met.


### Input parameters:
 
 Edit **modelWorkflow_inputs.json** file to specify the run parameters for the model.

 First specify the name of the run for the model (do not include spaces).\
 For **Bayesian**, provide state, start_date and end_date.\

 All other input parameters specify the model particulars, such as git repository, output folder of the model, types of output produced, installation and  run scripts.

~~~
{
  "modelWorkflow.name_of_this_model_run": "bayesian",
  "modelWorkflow.state_array": ["GA"],
  "modelWorkflow.start_date_array": ["2020-03-05"],
  "modelWorkflow.end_date_array": ["2020-03-07"],
  "modelWorkflow.model_git_repository": "https://github.com/midas-network/bayesian-covid-model-demo.git",
  "modelWorkflow.model_output_folder": "bayesian-covid-model-demo/scripts/results",
  "modelWorkflow.model_output_file_types": "[npz,txt,png]",
  "modelWorkflow.install_model_script": "./scripts/sh/bayesian/install_model.sh",
  "modelWorkflow.run_model_script": "./scripts/sh/bayesian/run_model.sh",
  "modelWorkflow.model_runtime_docker": "python:3.6.15-bullseye",

  "modelWorkflow.setup_os_script": "./scripts/sh/setup_os.sh",
  "modelWorkflow.clone_repository_script": "./scripts/sh/clone_git_repository.sh",
  "modelWorkflow.copy_cromwell_logs_script": "./scripts/sh/copy_cromwell_logs.sh",
  "modelWorkflow.copy_model_output_script": "scripts/python/copy_model_output.py"
}
~~~

## To execute:
 
 1. From the command line execute the Cromwell workflow
~~~
./cromwell_workflow.sh
~~~


## Results:

Results will be inside the model_output folder of this project:
~~~
~/../cromwell-bayesain-model-covid/model_output
~~~
