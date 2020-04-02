provider "aws" {
  region = var.region
}

module "random_pet" {
  source = "../modules/random_pet"
}

module "s3" {
  prefix = var.prefix
  source = "../modules/s3"
  name   = module.random_pet.name
}


module webapp {
  source = "../modules/webapp"
  bucket = module.s3.bucket 
}

