# Ruby on Rails Application on AWS ECS with Terraform

## Overview

This repository contains Terraform Infrastructure as Code (IaC) to deploy a Ruby on Rails application with NGINX as a reverse proxy on **AWS ECS EC2**. It includes provisioning of the following:

- VPC with public and private subnets
- Application Load Balancer (ALB)
- ECS cluster and service running Rails and NGINX containers in a Task
- RDS PostgreSQL database in private subnet
- IAM roles and policies for ECS tasks
- CloudWatch logging for containers
- Codepipeline to Automate the Deployment process in the ECS Service

---

## Steps needs to done before Hosting Application
### 1. ".tfvar" file
Write the ".tfvar" file with the required variables 
The variables are defined in the **`infrastructure/variables.tf`**

### 2. Docker image
Build a docker image for Rails and Nginx with the Dockerfile locate on **`docker/app/Dockerfile`** & **`docker/nginx/Dockerfile`**
- Push that Docker image to ECR repo.
- Add that ECR Repo's "image URI" on the .tfvar file.

## 3. Build Infrastructure
Run the Terraform comments on the **`infrastructure`** directory
 - terraform init
 - terraform plan 
 - terraform apply


## How Infrastructure will be created 
VPC with 2 Public and Private Subnets, Public and Private Route Tables, Internet gateway, NAT gateway in 2 Availability Zone(ap-south-1a, ap-south-1b)

ECS Cluster with EC2 Auto-Scaling Capacity Provider.

ECS service to maintain a Task which has Rails and Nginx container in Private Subnet.

Application Load balancer on Public subnet which route the traffic to Nginx container which is on Dynamic port mapping.

Secutiry group will be created for ALB, ECS and RDS separately.

RDS which is multi-az on Private Subnet. While launching container createing and migrating db will be done by the entrypoint file **`docker/app/entrypoint.sh`**.

Nginx will act as reverse proxy for Rails. The config file is present on **`docker/nginx/default.conf`**.

Create Codepipeline with the custom steps to Automatically Deploy your changes on the ECS Service.
 - CodeBuild with the **`buildspec.yml`** file
 - Deploy on AWS ECS 


## Issue with the code
### Issue
PostgreSQL RDS is not connecting to Rails App.

Reason: Missing adapter for postgresql.

Changes Done:
 - Added “adapter: postgresql” in the **`config/database.yml`** so that it will connect to the RDS PostgreSQL.
 - Added psql version “gem 'pg', '~> 1.5'” in Gemfile.