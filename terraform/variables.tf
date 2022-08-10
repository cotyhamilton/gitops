variable "do_token" {
  type        = string
  description = "DigitalOcean API token used to create infrastructure"
  sensitive   = true
}

variable "do_ssh_key_name" {
  type        = string
  description = "Name of an ssh public key in DigitalOcean"
  default     = "terraform"
}

variable "do_ssl_cert_name" {
  type        = string
  description = "Name of the ssl cert to be used by the load balancer"
  default     = "k3s"
}

variable "do_domain_name" {
  type        = string
  description = "Name of the domain to be used by the cluster"
}

variable "droplet_image" {
  type        = string
  description = "DigitalOcean Snapshot ID that was returned from Packer"
}

variable "private_key_path" {
  type        = string
  description = "Path to private key on system"
  default     = "~/.ssh/id_rsa"
}

variable "k3s_token" {
  type        = string
  description = "Token for registering k3s nodes"
  sensitive   = true
}