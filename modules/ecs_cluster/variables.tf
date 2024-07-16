variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "enable_container_insights" {
  description = "Enable CloudWatch Container Insights for the cluster"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to the ECS cluster"
  type        = map(string)
  default     = {}
}