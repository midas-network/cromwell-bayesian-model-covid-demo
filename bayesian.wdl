version 1.0

task run_bayesian {
    input {
        File setup_os_script
        File clone_repository_script
        File copy_cromwell_logs_script
        File copy_model_output_script
        String name_of_this_model_run
        String state
        String start_date
        String end_date
        String model_git_repository
        File install_model_script
        File run_model_script
        String model_output_folder
        String model_output_file_types
        String model_runtime_docker
        Int scatter_levels
    }

    String model_output_file_listing = "${name_of_this_model_run}_output_files.txt"

    command {
        ${setup_os_script}
        ${clone_repository_script} "${model_git_repository}"
        ${install_model_script} "${model_git_repository}"
        ${run_model_script} "${model_git_repository}" "${state}" "${start_date}" "${end_date}"
        python3 ${copy_model_output_script} "${scatter_levels}" "${model_output_folder}" "${model_output_file_types}" "${model_output_file_listing}" "${name_of_this_model_run}"
        ${copy_cromwell_logs_script} "${scatter_levels}" "${model_output_folder}" "${name_of_this_model_run}"
    }
    runtime {
        docker: "${model_runtime_docker}"
    }
    output {
        Array[File] output_files = read_lines(model_output_file_listing)
    }
}

workflow modelWorkflow {
    input {
        File setup_os_script
        File clone_repository_script
        File copy_cromwell_logs_script
        File copy_model_output_script
        String name_of_this_model_run
        Array[String] state_array
        Array[String] start_date_array
        Array[String] end_date_array
        String model_git_repository
        File install_model_script
        File run_model_script
        String model_output_folder
        String model_output_file_types
        String model_runtime_docker
    }

    scatter (state in state_array) {
        scatter (start_date in start_date_array) {
            scatter (end_date in end_date_array) {

                String name = name_of_this_model_run + "_" + state + "_" + start_date + "_" + end_date 

                call run_bayesian {
                    input:
                        setup_os_script = setup_os_script,
                        clone_repository_script = clone_repository_script,
                        copy_cromwell_logs_script = copy_cromwell_logs_script,
                        copy_model_output_script = copy_model_output_script,
                        name_of_this_model_run = name,
                        state = state,
                        start_date = start_date,
                        end_date = end_date,
                        model_git_repository = model_git_repository,
                        install_model_script = install_model_script,
                        run_model_script = run_model_script,
                        model_output_folder = model_output_folder,
                        model_output_file_types = model_output_file_types,
                        model_runtime_docker = model_runtime_docker,
                        scatter_levels = 3
                }
            }
        }
    }
}

