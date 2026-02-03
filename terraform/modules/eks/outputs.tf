output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_name" {
    description = "The name of the cluster"
    value       = aws_eks_cluster.main.name
}

output "cluster_arn" {
    description = "The ARN of the cluster"
    value       = aws_eks_cluster.main.arn
}
