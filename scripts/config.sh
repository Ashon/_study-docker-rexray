#!/bin/bash

# script configurations
ROOT=./
SSHCONFIG_PATH=$ROOT.vagrant/sshconfig
ANSIBLE_INVENTORY_PATH=$ROOT.vagrant/inventory

# aws configurations
# get from env or set
AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
