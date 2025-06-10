#!/bin/bash

# List all objects in an S3 bucket
# Usage: ./list-objects.sh <bucket-name> [prefix]

echo "Listing objects in S3 bucket..."
BUCKET="$1"
PREFIX="$2"

if [ -z "$BUCKET" ]; then
    echo "Usage: $0 <bucket-name> [prefix]"
    exit 1
fi

echo "Listing objects in S3 bucket using s3..."
if [ -z "$PREFIX" ]; then
    aws s3 ls "s3://$BUCKET/" --recursive
else
    aws s3 ls "s3://$BUCKET/$PREFIX" --recursive
fi

# Alternative: List objects using s3api
echo "Listing objects in S3 bucket using s3api..."
if [ -z "$PREFIX" ]; then
    aws s3api list-objects-v2 --bucket "$BUCKET" --output table
else
    aws s3api list-objects-v2 --bucket "$BUCKET" --prefix "$PREFIX" --output table
fi