# 1. EKS Cluster Resource
resource "aws_eks_cluster" "eks" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  # FIX: The vpc_config block is mandatory and must wrap subnet_ids
  vpc_config {
    subnet_ids = [
      "subnet-036c062b98e1ae753", # Replace with your actual Subnet IDs
      "subnet-05321b77a54840ad1"
    ]
    endpoint_public_access = true
  }

  # Ensure IAM Role permissions are created before the cluster
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy
  ]
}

# 2. IAM Role for EKS Cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}

# 3. Attach Required Policy to the Role
resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# 4. (Optional) Output the Cluster Endpoint
output "endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks.certificate_authority[0].data
}
