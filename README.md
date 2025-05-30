# shoplift-takehome!

The goal of the assessment is to create a Google Cloud Storage (GCS) bucket with a unique name using a random suffix and optional lifecycle policies for time-series data archiving. The bucket is created with the `STANDARD` storage class and versioning enabled. If specified, the module will also create IAM members with read-only access to the bucket. The IAM members are created with the `roles/storage.objectViewer` role, which grants read-only access to the objects in the bucket.

The module is designed to be used with the Terraform Google Provider, and the `google` provider must be configured before using this module.


### terraform show 

```bash
# module.timeseries_archive.google_storage_bucket.archive:
resource "google_storage_bucket" "archive" {
    default_event_based_hold    = false
    force_destroy               = false
    id                          = "dev-timeseries-oui2"
    labels                      = {}
    location                    = "US-CENTRAL1"
    name                        = "dev-timeseries-oui2"
    project                     = "poc-temp-01"
    public_access_prevention    = "inherited"
    requester_pays              = false
    self_link                   = "https://www.googleapis.com/storage/v1/b/dev-timeseries-oui2"
    storage_class               = "STANDARD"
    uniform_bucket_level_access = true
    url                         = "gs://dev-timeseries-oui2"

    lifecycle_rule {
        action {
            storage_class = "ARCHIVE"
            type          = "SetStorageClass"
        }
        condition {
            age                        = 90
            created_before             = null
            custom_time_before         = null
            days_since_custom_time     = 0
            days_since_noncurrent_time = 0
            matches_prefix             = []
            matches_storage_class      = [
                "STANDARD",
                "NEARLINE",
                "COLDLINE",
            ]
            matches_suffix             = []
            noncurrent_time_before     = null
            num_newer_versions         = 0
            with_state                 = null
        }
    }
    lifecycle_rule {
        action {
            storage_class = "COLDLINE"
            type          = "SetStorageClass"
        }
        condition {
            age                        = 30
            created_before             = null
            custom_time_before         = null
            days_since_custom_time     = 0
            days_since_noncurrent_time = 0
            matches_prefix             = []
            matches_storage_class      = [
                "STANDARD",
                "NEARLINE",
            ]
            matches_suffix             = []
            noncurrent_time_before     = null
            num_newer_versions         = 0
            with_state                 = null
        }
    }
    lifecycle_rule {
        action {
            storage_class = null
            type          = "Delete"
        }
        condition {
            age                        = 365
            created_before             = null
            custom_time_before         = null
            days_since_custom_time     = 0
            days_since_noncurrent_time = 0
            matches_prefix             = []
            matches_storage_class      = []
            matches_suffix             = []
            noncurrent_time_before     = null
            num_newer_versions         = 0
            with_state                 = null
        }
    }

    soft_delete_policy {
        effective_time             = "2025-05-30T16:10:32.984Z"
        retention_duration_seconds = 604800
    }
}

# module.timeseries_archive.google_storage_bucket_iam_member.viewers["user:jrab6692@gmail.com"]:
resource "google_storage_bucket_iam_member" "viewers" {
    bucket = "b/dev-timeseries-oui2"
    etag   = "CAM="
    id     = "b/dev-timeseries-oui2/roles/storage.objectViewer/user:jrab6692@gmail.com"
    member = "user:jrab6692@gmail.com"
    role   = "roles/storage.objectViewer"
}

# module.timeseries_archive.random_string.bucket_suffix:
resource "random_string" "bucket_suffix" {
    id          = "oui2"
    length      = 4
    lower       = true
    min_lower   = 0
    min_numeric = 0
    min_special = 0
    min_upper   = 0
    number      = true
    numeric     = true
    result      = "oui2"
    special     = false
    upper       = false
}


Outputs:

timeseries_bucket_name = "dev-timeseries-oui2"
timeseries_bucket_url = "gs://dev-timeseries-oui2"

```
