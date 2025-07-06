terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "3.0.2"
    }
  }
}
provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}


resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = "argocd"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "8.1.2" 

  values = [
    file("${path.module}/values.yaml")
  ]
}
