output "ecr_name" {
  value = module.ecr.ecr_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "The CA data for the EKS cluster"
  value       = module.eks.cluster_certificate_authority_data
}

output "cluster_arn" {
  description = "The ARN of the EKS cluster"
  value       = module.eks.cluster_arn
}

output "lb_controller_policy_arn" {
  description = "The ARN of the policy"
  value       = module.aws_load_balancer_controller_policy.policy_arn
}

output "backend_pod_policy_arn" {
  description = "The ARN of the backend pod policy"
  value       = module.eks_backend_pod_policy.policy_arn
}