resource "random_string" "bucket_suffix" {
  length  = 4
  special = false
  upper   = false
  lower   = true
}
resource "google_storage_bucket" "archive" {
  name                        = "${var.name_prefix}-${random_string.bucket_suffix.result}"
  project                     = var.project_id
  location                    = var.location
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.enable_uniform_bucket_level_access
  force_destroy               = false

  dynamic "lifecycle_rule" {
    for_each = var.transition_to_archive_days > 0 ? [1] : []
    content {
      action {
        type          = "SetStorageClass"
        storage_class = "ARCHIVE"
      }
      condition {
        age                   = var.transition_to_archive_days
        matches_storage_class = ["STANDARD", "NEARLINE", "COLDLINE"]
      }
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.transition_to_coldline_days > 0 ? [1] : []
    content {
      action {
        type          = "SetStorageClass"
        storage_class = "COLDLINE"
      }
      condition {
        age                   = var.transition_to_coldline_days
        matches_storage_class = ["STANDARD", "NEARLINE"]
      }
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.expiration_days > 0 ? [1] : []
    content {
      action {
        type = "Delete"
      }
      condition {
        age = var.expiration_days
      }
    }
  }
}

resource "google_storage_bucket_iam_member" "viewers" {
  for_each = toset(var.viewers)
  
  bucket = google_storage_bucket.archive.name
  role   = "roles/storage.objectViewer"
  member = each.key
}
