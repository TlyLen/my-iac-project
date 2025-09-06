variable "cluster_name" {
  description = "The name of the TKE cluster."
  type        = string
  default     = "my-tke-cluster"
}

variable "k8s_version" {
  description = "The version of Kubernetes to use for the TKE cluster."
  type        = string
  default     = "1.28.4"
}

variable "instance_type" {
  description = "The instance type for the TKE worker nodes."
  type        = string
  default     = "SA2.MEDIUM2" # 标准型SA2, 2核2G
}

variable "kubeconfig_path" {
  description = "The path to save the kubeconfig file."
  type        = string
  default     = "./kubeconfig.yaml"
}
