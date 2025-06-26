resource "google_container_cluster" "primary" {
  name     = "lbg-build-farm"
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.lbg_vpc_network.name
  subnetwork = google_compute_subnetwork.default.name
}

resource "google_container_node_pool" "primary_nodes" {
  name       = google_container_cluster.primary.name
  location   = var.region
  cluster    = google_container_cluster.primary.name

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.projectid
    }
        
    machine_type = "e2-standard-16"
    disk_size_gb = 128
    tags         = ["build-node", "${var.projectid}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
    
  autoscaling {
    total_max_node_count = var.maxnodecount
    total_min_node_count = var.minnodecount
  }
}

# resource "kubernetes_namespace" "lbg-worker" {
#   metadata {
#     name = "lbg-worker"
#   }
# }

# resource "kubernetes_namespace" "lbg" {
#   count = var.delegatecount 
#   metadata {
#     name = "lbg-${count.index + 1}"
#   }
# }