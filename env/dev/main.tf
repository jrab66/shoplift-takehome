module "timeseries_archive" {
  source = "../../modules/gcs-timeseries-archive"

  project_id  = var.project_id
  name_prefix = "${var.environment}-timeseries"
  location    = var.region

  # Storage class transitions
  transition_to_coldline_days = 30
  transition_to_archive_days  = 90
  expiration_days             = 365

  # IAM members with viewer access
  viewers = [
    # "group:data-viewers@your-org.com",  # other organization users, my PoC account is not a fully fledged GCP account!
    "user:jrab6692@gmail.com"
  ]

  enable_uniform_bucket_level_access = true
}