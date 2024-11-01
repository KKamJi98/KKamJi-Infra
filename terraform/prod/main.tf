provider "aws" {
  region = "ap-northeast-2"
}

terraform {
  required_version = ">= 1.9.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.73.0"
    }
  }

  backend "s3" {
    bucket  = "kkamji-app-terraform-state"
    key     = "kkamji-app/terraform.tfstate"
    region  = "ap-northeast-2"
    encrypt = true
  }
}

module "vpc" {
  source                  = "../modules/vpc"
  name                    = "kkamji-app"
  vpc_availability_zones  = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
  vpc_cidr                = "10.10.0.0/16"
  vpc_name                = "kkamji-app"
  public_subnet_suffix    = "kkamji-app-public"
  public_subnets_cidr     = ["10.10.100.0/24", "10.10.110.0/24", "10.10.120.0/24"]
  private_subnet_suffix   = "kkamji-app-private"
  private_subnets_cidr    = ["10.10.200.0/24", "10.10.210.0/24", "10.10.220.0/24"]
  map_public_ip_on_launch = true
  enable_dns_support      = true
  enable_dns_hostnames    = true
}

module "ecr" {
  source = "../modules/ecr"
  name   = "kkamji-app-backend"
}

module "eks" {
  source                   = "../modules/eks"
  cluster_name             = "kkamji-eks"
  cluster_version          = "1.31"
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnet_ids
  control_plane_subnet_ids = module.vpc.public_subnet_ids
  instance_types           = ["t3.medium"]
  min_size                 = 1
  max_size                 = 3
  desired_size             = 1
  key_name                 = "KKamJi2024"
  user_data = base64encode(templatefile("../templates/user_data.sh", {
    cluster_name = "kkamji-eks"
    max_pods     = 110
  }))
}

resource "aws_iam_role_policy_attachment" "ebs_csi_policy" {
  role       = module.eks.eks_node_group_iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = module.eks.eks_node_group_iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_agent_role" {
  role       = module.eks.eks_node_group_iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

module "aws_load_balancer_controller_policy" {
  source      = "../modules/iam_policy"
  name        = "AWSLoadBalancerControllerPolicy"
  policy_file = "../templates/lb_controller_policy.json"
}

module "eks_backend_pod_policy" {
  source      = "../modules/iam_policy"
  name        = "KKamJiBackendPodPolicy"
  policy_file = "../templates/backend_pod_policy.json"
}


module "waf" {
  source      = "../modules/waf"
  name        = "kkamji-app-waf"
  scope       = "REGIONAL"
  metric_name = "kkamji-app-waf-metric"
}