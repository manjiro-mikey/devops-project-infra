#!/bin/bash

# Run this file first and last
# Destroy Resources
terraform destroy -auto-approve

# Clean-Up 
rm -rf .terraform*
rm -rf terraform.tfstate*

# Clean data file in Output_files folder
rm -f ../Output_files/*