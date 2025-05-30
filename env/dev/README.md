# Dev Environment - GCS Timeseries Archive

This directory contains the Terraform configuration for the development environment's GCS Timeseries Archive.

## Prerequisites

- Terraform >= 1.0.0
- Google Cloud SDK installed and authenticated
- Appropriate GCP project permissions

## Configuration

1. Copy `terraform.tfvars.example` to `terraform.tfvars` and update the values:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Update the following variables in `terraform.tfvars`:
   - `project_id`: Your GCP project ID
   - `region`: GCP region (default: us-central1)
   - `environment`: Environment name (default: dev)

## Usage

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Review the execution plan:
   ```bash
   terraform plan
   ```

3. Apply the configuration:
   ```bash
   terraform apply
   ```

## Outputs

After applying the configuration, the following outputs will be displayed:

- `timeseries_bucket_name`: The name of the created GCS bucket
- `timeseries_bucket_url`: The gsutil URI of the bucket

## Lifecycle Rules

The bucket is configured with the following lifecycle rules:
- Objects transition to COLDLINE storage class after 30 days
- Objects transition to ARCHIVE storage class after 90 days
- Objects are automatically deleted after 365 days

## IAM Access

Viewer access is granted to the following IAM members by default:
- `group:data-viewers@your-org.com`

Update the `viewers` list in `main.tf` to modify access permissions.
