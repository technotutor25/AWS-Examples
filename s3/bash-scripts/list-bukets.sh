#!/bin/bash

echo "Listing all S3 buckets in your AWS account..."
# List all S3 buckets in your AWS account
aws s3 ls

echo "Listing all S3 buckets sorted by name using s3api..."
aws s3api list-buckets --query "Buckets[].Name" --output text | tr '\t' '\n' | sort

echo "Listing all S3 buckets with their creation dates, sorted by creation date..."
aws s3api list-buckets --query "Buckets[].[Name,CreationDate]" --output text | sort -k2