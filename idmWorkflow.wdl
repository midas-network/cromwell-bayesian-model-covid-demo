version 1.0

task run_Model {
    input {
        File setup_os_script
        File install_git_script
        File install_python_script
        File install_model_script
        File run_model_script
        String git_repository_url
        String state
        String start_date
        String end_date
    }
    command {
        ${setup_os_script}
        ${install_git_script}
        ${install_python_script}
        ${install_model_script} "${git_repository_url}"
        ${run_model_script} "${git_repository_url}" "${state}" "${start_date}" "${end_date}"
    }
    runtime {
        docker: "python:3.6.15-bullseye"
    }
    output {
        File response = stdout()
    }
}

workflow idmWorkflow {
    call run_Model {
        input:
            setup_os_script = "./scripts/sh/setup_os.sh",
            install_git_script = "./scripts/sh/install_git.sh",
            install_python_script = "./scripts/sh/install_python.sh",
            install_model_script = "./scripts/sh/install_model.sh",
            run_model_script = "./scripts/sh/run_model.sh",
            git_repository_url = "https://github.com/midas-network/cknowledge-covid-model.git",
	        state = "PA",
	        start_date = "2020-03-05",
	        end_date = "2020-03-07"
    }
}

