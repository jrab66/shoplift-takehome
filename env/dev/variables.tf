variable "project_id" {
  description = "The GCP project ID where resources will be created"
  type        = string
}

variable "region" {
  description = "The GCP region where resources will be created"
  type        = string
  default     = "us-central1"
}

variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}


# Output the bucket details
output "timeseries_bucket_name" {
  value = module.timeseries_archive.bucket_name
}

output "timeseries_bucket_url" {
  value = module.timeseries_archive.bucket_url
}
