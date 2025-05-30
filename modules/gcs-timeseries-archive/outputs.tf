output "bucket_name" {
  description = "The name of the created GCS bucket"
  value       = google_storage_bucket.archive.name
}

output "bucket_url" {
  description = "The gsutil URI of the bucket"
  value       = "gs://${google_storage_bucket.archive.name}"
}
