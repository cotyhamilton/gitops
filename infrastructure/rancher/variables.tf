# Variables for Rancher Infrastructure

variable "pvt_key" {
  type        = string
  description = "Path to private key"
}

variable "do_token" {
  type        = string
  description = "DigitalOcean API token used to create infrastructure"
  sensitive   = true
}

variable "do_region" {
  type        = string
  description = "DigitalOcean region used for all resources"
  default     = "nyc1"
}

variable "prefix" {
  type        = string
  description = "Prefix added to names of all resources"
  default     = "quickstart"
}

variable "droplet_image" {
  type        = string
  description = "Droplet image used for all droplets"
  default     = "ubuntu-20-04-x64"
}

variable "droplet_size" {
  type        = string
  description = "Droplet size used for all droplets"
  default     = "s-2vcpu-4gb"
}

variable "rancher_kubernetes_version" {
  type        = string
  description = "Kubernetes version to use for Rancher server cluster"
  default     = "v1.21.11+k3s1"
}

variable "cert_manager_version" {
  type        = string
  description = "Version of cert-manager to install alongside Rancher (format: 0.0.0)"
  default     = "1.7.1"
}

variable "rancher_version" {
  type        = string
  description = "Rancher server version (format: v0.0.0)"
  default     = "v2.6.4"
}

variable "rancher_root_domain" {
  type        = string
  description = "Root domain for rancher"
}

variable "rancher_sub_domain" {
  type        = string
  description = "Sub domain for rancher"
  default     = "rancher"
}

variable "lets_encrypt_email" {
  type        = string
  description = "Lets encrypt email"
}
