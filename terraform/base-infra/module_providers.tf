provider "oci" {
  alias  = "region_1"
  region = var.region_1
}

provider "oci" {
  alias  = "region_2"
  region = var.region_2
}

provider "oci" {
  alias  = "home"
  region = lookup(data.oci_identity_regions.home_region.regions[0], "name")
}