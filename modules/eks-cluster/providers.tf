provider "kubernetes" {
  version     = "~> 1.7"
  config_path = local_file.kube_config.filename
}

data "aws_availability_zones" "available" {}

provider "http" {
  version = "~> 1.1"
}

provider "local" {
  version = "~> 1.2"
}

provider "null" {
  version = "~> 2.1"
}
provider "tls"{
  version = "~>2.0.1"
}