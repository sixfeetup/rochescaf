
data "aws_ami" "os" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "tls_private_key" "deploy_key" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "default_key" {
  key_name   = "rochescaf_deploy_key"
  public_key = tls_private_key.deploy_key.public_key_openssh
}

locals {
  cluster_required_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

module "control_plane_nodes" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.6.1"

  count = var.control_plane.num_instances

  name                        = "${var.cluster_name}-${count.index}"
  ami                         = var.control_plane.ami_id == null ? data.aws_ami.os.id : var.control_plane.ami_id
  monitoring                  = true
  instance_type               = var.control_plane.instance_type
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  subnet_id                   = element(module.vpc.public_subnets, count.index)
  iam_role_use_name_prefix    = false
  create_iam_instance_profile = false
  tags                        = merge(local.common_tags, local.cluster_required_tags)
  key_name                    = aws_key_pair.default_key.key_name

  vpc_security_group_ids = [module.cluster_sg.security_group_id]

  root_block_device = [
    {
      volume_type = "gp3"
      volume_size = var.control_plane.disk_size
    }
  ]

}

