terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.39.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.37.0"
    }
  }
}

provider "google" {
    credentials = file(var.credentialfile)

    project = var.projectid
    region = var.region
    zone = var.zone
}

provider "kubernetes" {  
  host = "https://${google_container_cluster.primary.endpoint}"
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
  token = data.google_client_config.provider.access_token
}

data "google_client_config" "provider" {}