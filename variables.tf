variable "private_key_path" {
  description = "Path to the private key used for SSH access"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy in"
  type        = string
  default     = "us-east-1"
}
