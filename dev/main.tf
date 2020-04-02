provider "aws" {
  region = var.region
}

terraform {
  backend "remote" {
    hostname      = "app.terraform.io"
    organization  = "rachel-test"

    workspaces {
      name = "dev-code-management"
    }
  }
}

module "random_pet" {
  source = "app.terraform.io/rachel-test/randompet/example"
}

module "s3" {
  prefix = var.prefix
  source = "app.terraform.io/rachel-test/s3/example"
  name   = module.random_pet.name
}


module webapp {
  source = "app.terraform.io/rachel-test/webapp/example"
  bucket = module.s3.bucket 
}

