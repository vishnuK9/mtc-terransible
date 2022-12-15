terraform {
  backend "remote" {
    organization = "OT_terransible"

    workspaces {
      name = "terransible"
    }
  }
}