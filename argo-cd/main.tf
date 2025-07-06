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


resource "helm_release" "argo_rollouts" {
  name       = "argo-rollouts"
  namespace  = "argo-rollouts"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-rollouts"
  version    = "2.37.7"

  values = [
    file("${path.module}/rollouts-values.yaml")
  ]
}
