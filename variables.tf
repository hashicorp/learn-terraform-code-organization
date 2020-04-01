variable "prod_region" {
  description = "This is where your EC2 instance will be deployed."
}

variable "dev_region" {
  description = "This is where your EC2 instance will be deployed."
}

variable "dev_prefix" {
  default = "dev"
}

variable "prod_prefix" {
  default = "prod"
}
