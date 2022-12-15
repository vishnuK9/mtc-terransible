terraform {
  cloud {
    organization = "OT_terransible"

    workspaces {
      name = "terransible"
    }
  }
}