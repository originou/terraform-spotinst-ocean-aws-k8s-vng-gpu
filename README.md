# Create ARM VNGs on Ocean Spark By Spot

## Motivation

- create a spot Vng with GPU instance type on an existing Ocean Spark Cluster using `terraform`

## Requirements

- `terraform` tool
- AWS profile credentials (var env `AWS_PROFILE`)

The terraform description will create 1 simple Spot VNG dedicated to GPU instances for Ofas.

## Setup

- create a local variable file. e.g: `touch terraform.tfvars`
  - `spotinst_account`: Spot account act-xxxx
  - `spotinst_token`: Spot token
  - `aws_region`: region of the AWS cluster e.g us-west-2
  - `ocean_id`: ocean cluster o-xxxxxx
  - `cluster_name` : name of the cluster
  - `image_id`: AMI id of the accelerated EKS node image (GPU), let it to null to let the module `aws_ami` find it itself.

## Steps

- init terraform : `terraform init`
- apply the creation : `terraform apply`

- to remove the VNGs (revert): `terraform destroy`
