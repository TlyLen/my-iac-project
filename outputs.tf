output "cluster_endpoint" {
  description = "The public endpoint of the TKE cluster."
  value       = tencentcloud_tke_cluster.my_cluster.cluster_external_endpoint
}

output "kubeconfig" {
  description = "The kubeconfig for the TKE cluster. Also saved to the local file specified in variables."
  value       = tencentcloud_tke_cluster.my_cluster.kube_config
  sensitive   = true
}

output "kubeconfig_file_path" {
  description = "Path to the generated kubeconfig file."
  value       = local_file.kubeconfig.filename
}
