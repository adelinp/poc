module "vpc" {
  source = "./modules/vpc"
  aws_region        = var.aws_region
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "iam" {
  source = "./modules/iam"
  lambda_arn       = module.lambda.lambda_arn
  apigateway_api_id = module.apigateway.api_id
  aws_region        = var.aws_region
  aws_account_id    = var.aws_account_id
}

module "s3" {
  source         = "./modules/s3"
  bucket_prefix  = "3tier-poc"
  cloudfront_oai_iam_arn  = module.cloudfront.cloudfront_oai_iam_arn
}

module "cloudfront" {
  source               = "./modules/cloudfront"
  s3_bucket_domain_name = module.s3.s3_bucket_domain_name
  }

module "lambda" {
  source        = "./modules/lambda"
  function_name = "3tier-backend"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  iam_role_arn  = module.iam.lambda_role_arn
  vpc_id        = module.vpc.vpc_id
  subnet_ids    = module.vpc.private_subnet_ids
  security_group_id = module.vpc.lambda_sg_id
  db_endpoint   = module.rds.db_endpoint
  db_username   = module.rds.db_username
  db_password   = module.rds.db_password
  rds_vpc_endpoint  = module.vpc.rds_vpc_endpoint_id
}

module "apigateway" {
  source     = "./modules/apigateway"
  api_name   = "3tier-api"
  lambda_arn = module.lambda.lambda_arn
  aws_region = var.aws_region
}

module "rds" {
  source       = "./modules/rds"
  db_name      = "threetierdb"
  db_username  = "admin"
  db_password  = var.db_password
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnet_ids
  security_group_id = module.vpc.rds_sg_id
}

output "api_url" {
  value = module.apigateway.api_endpoint
}