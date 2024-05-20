#!/bin/bash


mapped_volume=/midas$1
model_output=$2
model_name=$3

if [[ ! -d "$mapped_volume"/model_output/"$model_name" ]]; 
then
  mkdir "$mapped_volume"/model_output/"$model_name"
fi

echo "Providing easy access to stderr and stdout..."
cp -f stderr "$mapped_volume"/model_output/"$model_name"
cp -f stdout "$mapped_volume"/model_output/"$model_name"
