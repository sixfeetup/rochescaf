module "cluster" {
  source                 = "../modules/base"
  environment            = "sandbox"
  cluster_name           = "rochescaf-sandbox"
  domain_name            = "sandbox.roche.scaf.sixfeetup.com"
  api_domain_name        = "api.sandbox.roche.scaf.sixfeetup.com"
  cluster_domain_name    = "k8s.sandbox.roche.scaf.sixfeetup.com"
  argocd_domain_name     = "argocd.sandbox.roche.scaf.sixfeetup.com"
  prometheus_domain_name = "prometheus.sandbox.roche.scaf.sixfeetup.com"
  existing_hosted_zone   = module.global_variables.existing_hosted_zone
  control_plane = {
    # 2 vCPUs, 4 GiB RAM, $0.0376 per Hour
    instance_type = "t3a.medium"
    num_instances = 1
    disk_size     = 100  # Size in GB
    # NB!: set ami_id to prevent instance recreation when the latest ami
    # changes, eg:
    # ami_id = "ami-09d22b42af049d453"

  }

  # NB!: limit admin_allowed_ips to a set of trusted
  # public ip addresses. Both variables are comma separated lists of ips.
    admin_allowed_ips = "102.218.60.202/32"
}
