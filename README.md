# AICYCLE-INFRA

## Introduction

This project uses Terraform to provision cloud resources and Ansible to automate the setup and configuration of Kubernetes. Additional addons and Helm packages required for the project are deployed automatically.

## Requirements

- Terraform
- Ansible
- Python with `hvac` library (for working with Vault)
- SSH access to servers

## Installation and Deployment

After initializing resources with Terraform, Ansible will automatically run with sequentially numbered tasks.
The vault.yml file alone requires a vault password to decrypt. Contact developer for availability.

<<<<<<< HEAD
##Example of /etc/ansible/hosts
[all]
192.168.80.245
192.168.80.186
192.168.80.195
192.168.80.150

[master]
master ansible_host=192.168.80.245

[workers]
worker1 ansible_host=192.168.80.186
worker2 ansible_host=192.168.80.196
worker3 ansible_host=192.168.80.195
worker4 ansible_host=192.168.80.150

[nginx-server]
#nginx ansible_host=192.168.80.194
worker4 ansible_host=192.168.80.150
nginx-worker ansible_host=192.168.80.150
=======

>>>>>>> 1fe74a30e56d7d34ae99583e3be87399bed93d71
