# Find a Accelerated AMI according to the region and for k8s 1.21

data "aws_ami" "aws_eks_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amazon-eks-gpu-node-1.21-*"]
  }
}
