#!/bin/bash
AWS_REGION=$1
EKS_CLUSTER_NAME=$2

ansible-playbook ansible/playbook.yaml -e "aws_region=${AWS_REGION} eks_cluster_name=${EKS_CLUSTER_NAME}"
