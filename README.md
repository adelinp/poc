# 3-Tier Scalable Application Deployment Using Terraform

This project demonstrates how to deploy a scalable 3-tier application using **Terraform modules** on AWS. The infrastructure follows best practices for modularity, security, and scalability.

---

## **Table of Contents**
1. [Modules](#-modules)
2. [Architecture Diagram](#architecture-diagram)
2. [How to Deploy](#-how-to-deploy)
   - [Prerequisites](#1%EF%B8%8F⃣-prerequisites)
   - [Deploy the Infrastructure](#2%EF%B8%8F⃣-deploy-the-infrastructure)
   - [Retrieve CloudFront URL](#3%EF%B8%8F⃣-retrieve-cloudfront-url)
3. [Scalability Features](#-scalability-features)
4. [Cleanup](#-cleanup)
5. [Conclusion](#-conclusion)
6. [References](#-references)

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

## **Architecture Diagram**

![Architecture Diagram](https://www.plantuml.com/plantuml/png/LP11J_90443lyolcuyHtQ3nmCyQW40m96gKnd8Vk21lQMToPGl3NkzkM46_jl9UTbvcgKRIsgU6VxRbXfBCM8PBi6FJWvKYH6gozi5sEZ27QFW1GPI7Yw5CvZf0Ks_G18C4nZcPrQDqY1Z4Sp-Pl_pkXoiElF1oiSeAbaVaADxnLRznfEXdmq_iINyZuJ9SEqD7l-jz1M56pTOIBLYhpGJgfxcRWo6XBcbzfw2S8hkSbZbylvSUgZubE0Mv5M1IFQJFUOydnn7eDcoN6Of1GDcu9oSnzQ_vkMGrk87j3HNAMSWe7ncUg3YmELs7dA-Xf5dD6ijPCxcuJlJ7EoUXFs4FHNJPR_IwzNWkcBAvjwby0)

---

## ** How to Deploy**
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

## ** References**
- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [AWS CloudFront](https://aws.amazon.com/cloudfront/)
- [AWS Lambda](https://aws.amazon.com/lambda/)
- [AWS API Gateway](https://aws.amazon.com/api-gateway/)

