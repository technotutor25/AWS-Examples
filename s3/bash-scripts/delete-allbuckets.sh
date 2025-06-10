#!/bin/bash

# Delete all S3 buckets and their contents recursively

# List all bucket names
buckets=$(aws s3api list-buckets --query "Buckets[].Name" --output text)

for bucket in $buckets; do
    echo "Deleting all objects in bucket: $bucket"
    aws s3 rm "s3://$bucket" --recursive

    echo "Deleting bucket: $bucket"
    aws s3api delete-bucket --bucket "$bucket"
done

echo "All buckets deleted."