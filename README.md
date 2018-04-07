# projectX
IaC w/ Deployment Pipeline

## Requirements:

* AWS Account
* Workstation with
  * [AWS CLI](https://aws.amazon.com/cli/) deployed
  * [HashiCorp Packer](https://www.packer.io) deployed
  * [HashiCorp Terraform](https://www.terraform.io) deployed
  * [Ansible](https://www.ansible.com) deployed
  * [Chef InSpec](https://www.chef.io/inspec/) deployed

## Usage

* Confirm the AWS CLI has been configured.  Either
  * run `aws configure`
  * set environment variables
    * export AWS_ACCESS_KEY_ID=********************
    * export AWS_SECRET_ACCESS_KEY=***************************************
    * export AWS_DEFAULT_REGION=us-west-2

* Set the IP for the management console
  * export TF_VAR_vpc_ingressIP=#.#.#.#

## Acknowledgments

Terraform and Packer inspired by/derived from [cloud-provisioning](https://github.com/vfarcic/cloud-provisioning).  Thanks to [Viktor Farcic](https://github.com/vfarcic).
