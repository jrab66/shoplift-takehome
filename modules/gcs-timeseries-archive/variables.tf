variable "project_id" {
  description = "The ID of the project to create the bucket in."
  type        = string
}

variable "name_prefix" {
  description = "Prefix for the GCS bucket name."
  type        = string
  default     = "timeseries-archive"
}

variable "location" {
  description = "The location of the bucket."
  type        = string
  default     = "US"
}

variable "storage_class" {
  description = "The Storage Class of the new bucket."
  type        = string
  default     = "STANDARD"
  
  validation {
    condition     = contains(["STANDARD", "NEARLINE", "COLDLINE", "ARCHIVE"], var.storage_class)
    error_message = "The storage class must be one of: STANDARD, NEARLINE, COLDLINE, or ARCHIVE."
  }
}

variable "enable_uniform_bucket_level_access" {
  description = "Enables Uniform Bucket-Level Access on the bucket."
  type        = bool
  default     = true
}

variable "transition_to_archive_days" {
  description = "Number of days after which to transition objects to ARCHIVE storage class. Set to 0 to disable."
  type        = number
  default     = 30
}

variable "transition_to_coldline_days" {
  description = "Number of days after which to transition objects to COLDLINE storage class. Set to 0 to disable."
  type        = number
  default     = 90
}

variable "expiration_days" {
  description = "Number of days after which to delete objects. Set to 0 to disable."
  type        = number
  default     = 365
}

variable "viewers" {
  description = "List of IAM members to grant storage.objectViewer role"
  type        = list(string)
  default     = []
}
