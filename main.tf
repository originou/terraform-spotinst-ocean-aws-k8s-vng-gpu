provider "spotinst" {
  token   = var.spotinst_token
  account = var.spotinst_account
}

provider "aws" {
  region = var.aws_region
}


## Create Ocean Virtual Node Group (launchspec) ##
## Spot with Accelerated AMI (GPU)
module "ocean-aws-k8s-vng_spot_gpu" {
  source = "spotinst/ocean-aws-k8s-vng/spotinst"

  cluster_name = var.cluster_name
  ocean_id     = var.ocean_id

  # Name of VNG in Ocean
  name = "ocean-spark-spot-gpu"

  image_id = data.aws_ami.aws_eks_ami.image_id

  min_instance_count = 1

  # Spot at 100%
  spot_percentage = 100

  # Root volume size (null to take from vng template)
  # spark image with Nvidia + CUDA drivers is too heavy actually
  # set to 100G to avoid `disk-pressure`
  root_volume_size = 100

  # supported instance with AWS Accelerated AMI (P2 and P3)
  instance_types = [
    // "p2.16xlarge",
    // "p2.xlarge",
    // "p2.8xlarge",
    "p3.2xlarge",
    "p3.16xlarge",
    "p3.8xlarge"
  ]

  # Add Labels or taints
  labels = [
    { key = "bigdata.spot.io/vng", value = "ocean-spark" },
    { key = "nvidia.com/gpu", value = "present" }
  ]

  taints = [
    {
      key    = "bigdata.spot.io/unschedulable",
      value  = "ocean-spark",
      effect = "NoSchedule"
    }
  ]
}
