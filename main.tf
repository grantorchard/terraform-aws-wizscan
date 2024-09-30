# resource "aws_s3_bucket" "this" {
#   bucket_prefix = "ignore-tags"
# }

# resource "aws_s3_bucket_public_access_block" "this" {
#   bucket = aws_s3_bucket.this.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = false
# }

data "aws_availability_zones" "this" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"
  cidr = "10.0.0.0/16"
  private_subnets = cidrsubnets("10.0.0.0/16", 8, 8, 8)
  azs = data.aws_availability_zones.this.ids
}

module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "20.24.2"

    cluster_endpoint_public_access = true
    cluster_endpoint_public_access_cidrs = [
        "192.168.17.0/24",
        "0.0.0.0/0"
    ]
    vpc_id     = module.vpc.vpc_id
    subnet_ids = module.vpc.private_subnets
}


