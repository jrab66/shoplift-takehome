# GCS Timeseries Archive Module

This Terraform module creates a Google Cloud Storage bucket with configurable lifecycle policies for time-series data archiving.

## Features

- Creates a GCS bucket with a unique name (using a random suffix)
- Configurable storage class (STANDARD, NEARLINE, COLDLINE, ARCHIVE)
- Optional Uniform Bucket-Level Access
- Configurable lifecycle rules for:
  - Transitioning objects to COLDLINE storage class
  - Transitioning objects to ARCHIVE storage class
  - Automatic object deletion after a specified period
- IAM member management for read-only access

## Usage

```hcl
module "timeseries_archive" {
  source = "./gcs-timeseries-archive"

  project_id  = "your-project-id"
  name_prefix = "my-timeseries-data"
  location    = "US"

  transition_to_coldline_days = 30
  transition_to_archive_days  = 90
  expiration_days             = 365

  viewers = [
    "user:user@example.com",
    "group:viewers@example.com",
    "serviceAccount:sa@project.iam.gserviceaccount.com"
  ]
}

output "bucket_name" {
  value = module.timeseries_archive.bucket_name
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_id | The ID of the project to create the bucket in | `string` | n/a | yes |
| name_prefix | Prefix for the GCS bucket name | `string` | `"timeseries-archive"` | no |
| location | The location of the bucket | `string` | `"US"` | no |
| storage_class | The Storage Class of the new bucket | `string` | `"STANDARD"` | no |
| enable_uniform_bucket_level_access | Enables Uniform Bucket-Level Access on the bucket | `bool` | `true` | no |
| transition_to_archive_days | Days until objects transition to ARCHIVE (0 to disable) | `number` | `30` | no |
| transition_to_coldline_days | Days until objects transition to COLDLINE (0 to disable) | `number` | `90` | no |
| expiration_days | Days until objects are deleted (0 to disable) | `number` | `365` | no |
| viewers | List of IAM members to grant storage.objectViewer role | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_name | The name of the created GCS bucket |
| bucket_url | The gsutil URI of the bucket |

## Requirements

- Terraform >= 1.0
- Google Provider >= 4.0

## Notes

- Bucket names are globally unique in GCP. The module appends a random suffix to the provided prefix to ensure uniqueness.
- When enabling lifecycle rules, make sure the transition days are in ascending order (e.g., transition to COLDLINE before ARCHIVE).
- The module enables versioning by default to protect against accidental deletions.
