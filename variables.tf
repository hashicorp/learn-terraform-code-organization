variable "prod_region" {
  description = "This is the cloud hosting region where your production webapp will be deployed."
}

variable "dev_region" {
  description =  "This is the cloud hosting region where your development webapp will be deployed."
}

variable "dev_prefix" {
  default = "dev"
}

variable "prod_prefix" {
  default = "prod"
}
