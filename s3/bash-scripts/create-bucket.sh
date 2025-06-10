#!/usr/bin/env bash

echo "Creating S3 bucket..."
# Usage: ./create-bucket.sh <bucket-name> [region]
if [ -z "$1" ]; then
    echo "Error: Bucket name is required."
    echo "Usage: $0 <bucket-name> [region]. Else defaults to us-east-1."
    exit 1
fi

BUCKET_NAME=$1
REGION=${2:-us-east-1}


if [ "$REGION" == "us-east-1" ]; then
    # aws s3api create-bucket --bucket "$BUCKET_NAME"
    aws s3api create-bucket --bucket "$BUCKET_NAME" --region us-east-1 --output text

else
    aws s3api create-bucket --bucket "$BUCKET_NAME" --region "$REGION" --create-bucket-configuration LocationConstraint="$REGION" --output text
    # aws s3api create-bucket --bucket "$BUCKET_NAME" --region eu-west-1 --create-bucket-configuration LocationConstraint=eu-west-1 --output text
fi

echo "Bucket '$BUCKET_NAME' created in region '$REGION'."