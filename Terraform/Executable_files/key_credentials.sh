#!/bin/bash

# Then need encoding
# Must work then "terraform init" command

export AWS_ACCESS_KEY_ID = ""
export AWS_SECRET_ACCESS_KEY = ""
export AWS_REGION = "us-east-1"

# Storage for logs
export TF_LOG = TRACE
export TF_LOG_PATH = "terraform-trace.log"