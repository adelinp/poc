# 3-Tier Scalable Application Deployment Using Terraform

This project demonstrates how to deploy a scalable 3-tier application using **Terraform modules** on AWS. The infrastructure follows best practices for modularity, security, and scalability.

Each module is self-contained, with its own variables, outputs, and resources, ensuring a clean and scalable infrastructure.

---

## **Table of Contents**
1. [File Structure](#file-structure)
2. [Modules](#modules)
3. [Architecture Diagram](#architecture-diagram)
4. [How to Deploy](#-how-to-deploy)
   - [Prerequisites](#prerequisites)
   - [Deploy the Infrastructure](#deploy-the-infrastructure)
   - [Retrieve CloudFront URL](#retrieve-cloudfront-url)
5. [Scalability Features](#-scalability-features)
6. [Cleanup](#-cleanup)
7. [Conclusion](#-conclusion)
9. [References](#-references)

---
## **File Structure**

Below is the **Terraform project structure**:

```
3tier-POC/
│── main.tf                  # Root Terraform configuration
│── variables.tf             # Global variables
│── outputs.tf               # Global outputs
│── terraform.tfvars         # User-defined variable values
│── README.md                # Documentation
│── modules/                 # Directory for Terraform modules
│   │── vpc/                 # VPC Module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │── s3/                  # S3 Static Hosting Module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │── cloudfront/          # CloudFront CDN Module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │── lambda/              # Lambda Backend Module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │── rds/                 # RDS Database Module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │── apigateway/          # API Gateway Module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │── iam/                 # IAM Roles and Policies Module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
```

Each module contains:

- AWS resources
- input variables
- module outputs

---
## **Modules**
This project is structured using Terraform modules for easy reusability:

| Module       | Description |
|-------------|------------|
| `vpc`       | Creates a VPC with public and private subnets |
| `s3`        | Configures an S3 bucket for static website hosting |
| `cloudfront`| Deploys CloudFront for content delivery |
| `iam`       | Creates necessary IAM roles for Lambda |
| `lambda`    | Deploys a serverless function for API processing |
| `apigateway`| Configures API Gateway for HTTP requests |
| `rds`       | Creates an RDS MySQL database |

---
### **How Modules are Created**

Terraform modules are created by:

1. **Defining resources** in `main.tf`
2. **Declaring input variables** in `variables.tf`
3. **Defining outputs** in `outputs.tf`

Example **Lambda Module**:

```hcl
resource "aws_lambda_function" "backend" {
  function_name    = var.function_name
  runtime         = var.runtime
  handler         = var.handler
  role            = var.iam_role_arn
  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [var.security_group_id]
  }
  environment {
    variables = {
      DB_ENDPOINT = var.db_endpoint
      DB_USER     = var.db_username
      DB_PASS     = var.db_password
    }
  }
}
```

Example **Variables**:

```hcl
variable "function_name" {}
variable "runtime" {}
variable "handler" {}
variable "iam_role_arn" {}
variable "subnet_ids" {
  type = list(string)
}
variable "security_group_id" {}
variable "db_endpoint" {}
variable "db_username" {}
variable "db_password" {}
```

Example **Outputs**:

```hcl
output "lambda_arn" {
  value = aws_lambda_function.backend.arn
}
```

###How Modules are Used###
Modules are used at the root level.

Example usage of the **Lambda module**:

```hcl
module "lambda" {
  source          = "./modules/lambda"
  function_name   = "3tier-backend"
  runtime        = "python3.9"
  handler        = "lambda_function.lambda_handler"
  iam_role_arn   = module.iam.lambda_role_arn
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnet_ids
  security_group_id = module.vpc.lambda_sg_id
  db_endpoint    = module.rds.db_endpoint
  db_username    = module.rds.db_username
  db_password    = module.rds.db_password
}
```

Each module is referenced using:

- `source = "./modules/<module-name>"` – Specifies the module location
- Input variables are mapped using `var.<variable-name>` or `module.<module-name>.<output>`

---

## **Architecture Diagram**

![Architecture Diagram](https://www.plantuml.com/plantuml/png/LP11J_90443lyolcuyHtQ3nmCyQW40m96gKnd8Vk21lQMToPGl3NkzkM46_jl9UTbvcgKRIsgU6VxRbXfBCM8PBi6FJWvKYH6gozi5sEZ27QFW1GPI7Yw5CvZf0Ks_G18C4nZcPrQDqY1Z4Sp-Pl_pkXoiElF1oiSeAbaVaADxnLRznfEXdmq_iINyZuJ9SEqD7l-jz1M56pTOIBLYhpGJgfxcRWo6XBcbzfw2S8hkSbZbylvSUgZubE0Mv5M1IFQJFUOydnn7eDcoN6Of1GDcu9oSnzQ_vkMGrk87j3HNAMSWe7ncUg3YmELs7dA-Xf5dD6ijPCxcuJlJ7EoUXFs4FHNJPR_IwzNWkcBAvjwby0)

---

## **How to Deploy**
### **Prerequisites**
- Install **Terraform** (>= v1.0)
- AWS CLI configured with credentials
- S3 bucket for remote Terraform state (optional)

### **Deploy the Infrastructure**
Run the following Terraform commands:
```bash
terraform init
terraform plan
terraform apply -auto-approve
```

### **Retrieve CloudFront URL**
After deployment, you can access the frontend using:
```bash
terraform output frontend_url
```
Copy and paste this URL into your browser to view the deployed application.

---

## **Scalability Features**
 **Modularized Terraform code** – Allows for reusability and easy updates.  
 **Auto-scaling backend** – Uses API Gateway + Lambda to scale on-demand.  
 **CloudFront caching** – Reduces latency and improves performance.  
 **Database is in a private subnet** – Secure and isolated access.  

---

## **Cleanup**
To destroy all resources:
```bash
terraform destroy -auto-approve
```

---

## **Conclusion**
This project demonstrates **how to deploy a scalable cloud application using Terraform modules**. By modularizing each component, we ensure **maintainability, reusability, and scalability**. 

---

## **References**
- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [AWS CloudFront](https://aws.amazon.com/cloudfront/)
- [AWS Lambda](https://aws.amazon.com/lambda/)
- [AWS API Gateway](https://aws.amazon.com/api-gateway/)
