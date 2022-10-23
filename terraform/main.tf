terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = "dop_v1_f04ede7df682bc50d0377f0619a62d61a5a901ffd95784ab287acb4ac45dd8bd"
}

resource "digitalocean_droplet" "Jenkins" {
  image  = "ubuntu-22-04-x64"
  name   = "jenkins"
  region = "nyc1"
  size   = "s-2vcpu-2gb"
  ssh_keys = [data.digitalocean_ssh_key.devopselite.id]
}

data "digitalocean_ssh_key" "devopselite" {
  name = "devopselite"
}

  resource "digitalocean_kubernetes_cluster" "k8s" {
  name   = "k8s"
  region = "nyc1"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.24.4-do.0"

  node_pool {
    name       = "default"
    size       = "s-2vcpu-2gb"
    node_count = 2
  }
}