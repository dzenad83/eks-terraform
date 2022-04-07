# Provisioning Infrastructure as Code - IaC #

## Description of IaC Process ##

Infrastructure as Code (IaC) is the process of initialization and management of infrastructure (networks, virtual machines, load balancers, and connection topology) by code. The template initiates EKS cluster, worker nodes, ecr, vpc, security groups, etc.

# Requirements
1. Manually create pem key manually in EC2 console. Naming: > **key-ec2-{project-name}.pem**
2. Setup manually an S3 backend and set the name of the bucket in > **terraform backend** in the main.tf file.


# How to run it

- To initializa terraform run > **terraform init**
- Create workspaces with 
    > terraform workspace new {env name}
    - **dev**
    - **stg**
    - **prod**
- To start working select the workspace 
    > terraform workspace select **dev**
- To run terraform plan on the required environment use **make** command followed as shown:
  -   > make plan-dev
  -   > make plan-stg
  -   > make plan-{env}
- To run terraform apply:
  -   > make apply-dev
  -   > make apply-stg
  -   > make apply-{env}
- To run terraform destroy:
  -   > make destroy-dev
  -   > make destroy-stg
  -   > make destroy-{env}

# Progress
Still in progress (Apr 7th 22)
