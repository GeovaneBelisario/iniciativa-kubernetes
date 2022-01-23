#qual provider o terraform vai usar
terraform {
  required_providers {
    digitalocean = {
      source   = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

#variavel para o token não ficar exposto num arquivo compartilhavel
variable "digital_ocean_token" {}
variable "nome_k8s" {}

#declaracao do provider
provider "digitalocean" {
  token = var.digital_ocean_token
}

#declarar a infraestrutura, criar um recurso no servico
resource "digitalocean_kubernetes_cluster" "k8s" {
  name = var.nome_k8s
  region = "nyc1"
  version = "1.21.3-do.0"

  node_pool {
    name = "default-pool"
    size = "s-2vcpu-4gb" #2vcpu, 4gb de ram
    node_count = 1
  }
}

#coloca um arquivo na maquina local
resource "local_file" "k8s_config" {
  content = digitalocean_kubernetes_cluster.k8s.kube_config.0.raw_config
  filename = "kube_config"
}