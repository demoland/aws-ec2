variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-2"
}

variable "management_pubkey" {
  type        = string
  description = "SSH Public Key"
  default     = "abcxyz"
}
