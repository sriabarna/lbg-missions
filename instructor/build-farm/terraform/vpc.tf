resource "google_compute_network" "lbg_vpc_network" {
  name = "lbg-build-farm-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default" {
  name          = "cohort-build-farm-subnet"  
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region  
  network       = google_compute_network.lbg_vpc_network.id
}
