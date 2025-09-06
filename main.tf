# Create a new VPC for the TKE cluster
resource "tencentcloud_vpc" "tke_vpc" {
  name       = "tke-vpc-for-${var.cluster_name}"
  cidr_block = "10.0.0.0/16"
}

# Create a subnet in the VPC
resource "tencentcloud_subnet" "tke_subnet" {
  vpc_id            = tencentcloud_vpc.tke_vpc.id
  name              = "tke-subnet-for-${var.cluster_name}"
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.tencentcloud_availability_zones_by_product.default.zones[0].name
}

# Get available zones
data "tencentcloud_availability_zones_by_product" "default" {
  product = "tke"
}

# Create a TKE cluster
resource "tencentcloud_tke_cluster" "my_cluster" {
  cluster_name              = var.cluster_name
  vpc_id                    = tencentcloud_vpc.tke_vpc.id
  subnet_id                 = tencentcloud_subnet.tke_subnet.id
  cluster_version           = var.k8s_version
  cluster_desc              = "My TKE cluster created by Terraform"
  cluster_cidr              = "172.16.0.0/16"
  ignore_cluster_cidr_conflict = false
  is_non_static_ip_mode     = true

  worker_config {
    count             = 1
    availability_zone = tencentcloud_subnet.tke_subnet.availability_zone
    instance_type     = var.instance_type
    subnet_id         = tencentcloud_subnet.tke_subnet.id
    system_disk_type  = "CLOUD_PREMIUM"
    system_disk_size  = 50
    
    # Use spot instance (bidding instance)
    instance_charge_type = "SPOTPAID"
    spot_instance_type   = "one-time"
    spot_max_price       = "0.5" # Set a reasonable max price
  }
}

# Save the kubeconfig to a local file
resource "local_file" "kubeconfig" {
  content  = tencentcloud_tke_cluster.my_cluster.kube_config
  filename = var.kubeconfig_path
}
