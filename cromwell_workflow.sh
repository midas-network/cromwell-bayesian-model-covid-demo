#!/bin/bash

# https://stackoverflow.com/questions/7334754/correct-way-to-check-java-version-from-bash-script
# returns the JDK version.
# 8 for 1.8.0_nn, 9 for 9-ea etc, and "no_java" for undetected
jdk_version() {
  local result
  local java_cmd
  if [[ -n $(type -p java) ]]
  then
    java_cmd=java
  elif [[ (-n "$JAVA_HOME") && (-x "$JAVA_HOME/bin/java") ]]
  then
    java_cmd="$JAVA_HOME/bin/java"
  fi
  local IFS=$'\n'
  # remove \r for Cygwin
  local lines=$("$java_cmd" -Xms32M -Xmx32M -version 2>&1 | tr '\r' '\n')
  if [[ -z $java_cmd ]]
  then
    result=no_java
  else
    for line in $lines; do
      if [[ (-z $result) && ($line = *"version \""*) ]]
      then
        local ver=$(echo $line | sed -e 's/.*version "\(.*\)"\(.*\)/\1/; 1q')
        # on macOS, sed doesn't support '?'
        if [[ $ver = "1."* ]]
        then
          result=$(echo $ver | sed -e 's/1\.\([0-9]*\)\(.*\)/\1/; 1q')
        else
          result=$(echo $ver | sed -e 's/\([0-9]*\)\(.*\)/\1/; 1q')
        fi
      fi
    done
  fi
  echo "$result"
}

echo "Checking JAVA installation and version..."
java_ver="$(jdk_version)"
if (( $java_ver > 10 ))
then
	java_installed=true
else
	echo "This application requires a minimum JAVA version of 11."
	exit 1
fi

echo "Checking DOCKER installation and version..."
if [[ $(which docker) && $(docker --version) ]]
then
	docker_installed=true
else
	echo "This application requires docker to be installed."
	exit 1
fi 

#echo "java " + $java_installed
#echo "docker " + $docker_installed

echo "Pulling Docker library ..."
docker pull python

echo "Downloading Cromwell (if necessary) ..."
FILE=cromwell-84.jar
if test -f "$FILE"
then
	echo "$FILE exists"
else
	wget https://github.com/broadinstitute/cromwell/releases/download/84/cromwell-84.jar
fi

echo "Running Cromwell workflow ..."
java -jar cromwell-84.jar run idmWorkflow.wdl
