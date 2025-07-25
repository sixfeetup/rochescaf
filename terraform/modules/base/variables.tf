variable "account_id" {
  description = "The AWS account ID"
  type        = string
  default     = "381492128493"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "app_name" {
  description = "Application Name"
  type        = string
  default     = "rochescaf"
}

variable "environment" {
  description = "Environment Name"
  type        = string
  default     = "sandbox"
}

variable "cluster_name" {
  description = "Name of cluster"
  type        = string
  default     = "rochescaf-sandbox"
}

variable "domain_name" {
  type    = string
  default = "roche.scaf.sixfeetup.com"
}

variable "api_domain_name" {
  type    = string
  default = "api.roche.scaf.sixfeetup.com"
}

variable "cluster_domain_name" {
  type    = string
  default = "k8s.roche.scaf.sixfeetup.com"
}

variable "nextjs_domain_name" {
  type    = string
  default = "nextjs.roche.scaf.sixfeetup.com"
}


variable "argocd_domain_name" {
  type    = string
  default = "argocd.roche.scaf.sixfeetup.com"
}


variable "prometheus_domain_name" {
  type    = string
  default = "prometheus.roche.scaf.sixfeetup.com"
}

variable "kubernetes_version" {

  description = "Kubernetes version to use for the cluster, if not set the k8s version shipped with the talos sdk or k3s version will be used"
  type        = string
  default     = null
}

variable "control_plane" {
  description = "Info for control plane that will be created"
  type = object({
    instance_type      = optional(string, "t3a.medium")
    ami_id             = optional(string, null)
    num_instances      = optional(number, 3)
    config_patch_files = optional(list(string), [])
    tags               = optional(map(string), {})
    disk_size          = optional(number, 100)
  })

  validation {
    condition     = var.control_plane.ami_id != null ? (length(var.control_plane.ami_id) > 4 && substr(var.control_plane.ami_id, 0, 4) == "ami-") : true
    error_message = "The ami_id value must be a valid AMI id, starting with \"ami-\"."
  }

  default = {}
}

variable "cluster_vpc_cidr" {
  description = "The IPv4 CIDR block for the VPC."
  type        = string
  default     = "172.16.0.0/16"
}



variable "repo_name" {
  type    = string
  default = "rochescaf"
}

variable "repo_url" {
  type    = string
  default = "git@github.com:sixfeetup/rochescaf.git"
}


variable "frontend_ecr_repo" {
  description = "The Frontend ECR repository name"
  type        = string
  default     = "rochescaf-sandbox-frontend"
}


variable "backend_ecr_repo" {
  description = "The backend ECR repository name"
  type        = string
  default     = "rochescaf-sandbox-backend"
}

variable "admin_allowed_ips" {
  description = "A list of CIDR blocks that are allowed to access the kubernetes api"
  type        = string
  default     = "0.0.0.0/0"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "existing_hosted_zone" {
  description = "Name of existing hosted zone to use instead of creating a new one"
  type        = string
  default     = "scaf.sixfeetup.com"
}
