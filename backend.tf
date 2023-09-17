terraform {
  backend "s3" {
    bucket                      = "velo-cite"
    key                         = "terraform.tfstate"
    region                      = "gra"
    endpoint                    = "s3.gra.io.cloud.ovh.net"
    skip_credentials_validation = true
    skip_region_validation      = true
  }
}
