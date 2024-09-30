data "aws_availability_zones" "this" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"
  cidr = var.vpc_subnet
  private_subnets = cidrsubnets(var.vpc_subnet, 8, 8, 8)
  azs = data.aws_availability_zones.this.zone_ids
}

module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "20.24.2"

    cluster_name = "brighter-tech " 
    cluster_endpoint_public_access = true
    cluster_endpoint_public_access_cidrs = [
        "192.168.17.0/24",
        "0.0.0.0/0"
    ]
    vpc_id     = module.vpc.vpc_id
    subnet_ids = module.vpc.private_subnetsa
}


