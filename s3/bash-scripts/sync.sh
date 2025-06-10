#!/bin/bash


if [ -z "$1" ]; then
    echo "Usage: $0 <bucket-name> <prefix>"
    exit 1
fi


# Generate a random number between 3 and 10
num_files=$((RANDOM % 8 + 3))

# Create output folder with timestamp
output_dir="output_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$output_dir"

# Create random number of files
for i in $(seq 1 $num_files); do
    echo "This is file $i" > "$output_dir/file_$i.txt"
    random_date=$(date -d "$((RANDOM % 365)) days ago" +"%Y-%m-%d")
    echo "Random date: $random_date" >> "$output_dir/file_$i.txt"
done

echo "Created $num_files files in $output_dir"

# Upload files to S3 bucke
bucket_name="$1"  # Replace with your bucket name
PREFIX="$2"

aws s3 cp "$output_dir/" "s3://$bucket_name/$PREFIX" --recursive
echo "Uploaded files to s3://$bucket_name/$PREFIX"

PREFIX="${PREFIX}_sync"
aws s3 sync "$output_dir/" "s3://$bucket_name/$PREFIX"
echo "Uploaded files to s3://$bucket_name/$PREFIX"

rm -rf "$output_dir"
echo "Deleted folder $output_dir"




# Output
# $ ./s3/bash-scripts/put-object.sh mybucket-dhans vlsa123
# Created 10 files in output_20250610_180312
# upload: output_20250610_180312\file_2.txt to s3://mybucket-dhans/vlsa123/file_2.txt
# upload: output_20250610_180312\file_5.txt to s3://mybucket-dhans/vlsa123/file_5.txt
# upload: output_20250610_180312\file_7.txt to s3://mybucket-dhans/vlsa123/file_7.txt
# upload: output_20250610_180312\file_3.txt to s3://mybucket-dhans/vlsa123/file_3.txt
# upload: output_20250610_180312\file_6.txt to s3://mybucket-dhans/vlsa123/file_6.txt
# upload: output_20250610_180312\file_10.txt to s3://mybucket-dhans/vlsa123/file_10.txt
# upload: output_20250610_180312\file_1.txt to s3://mybucket-dhans/vlsa123/file_1.txt
# upload: output_20250610_180312\file_4.txt to s3://mybucket-dhans/vlsa123/file_4.txt
# upload: output_20250610_180312\file_8.txt to s3://mybucket-dhans/vlsa123/file_8.txt
# upload: output_20250610_180312\file_9.txt to s3://mybucket-dhans/vlsa123/file_9.txt
# Uploaded files to s3://mybucket-dhans/vlsa123
# upload: output_20250610_180312\file_1.txt to s3://mybucket-dhans/vlsa123_sync/file_1.txt
# upload: output_20250610_180312\file_7.txt to s3://mybucket-dhans/vlsa123_sync/file_7.txt
# upload: output_20250610_180312\file_2.txt to s3://mybucket-dhans/vlsa123_sync/file_2.txt
# upload: output_20250610_180312\file_10.txt to s3://mybucket-dhans/vlsa123_sync/file_10.txt
# upload: output_20250610_180312\file_6.txt to s3://mybucket-dhans/vlsa123_sync/file_6.txt
# upload: output_20250610_180312\file_3.txt to s3://mybucket-dhans/vlsa123_sync/file_3.txt
# upload: output_20250610_180312\file_4.txt to s3://mybucket-dhans/vlsa123_sync/file_4.txt
# upload: output_20250610_180312\file_8.txt to s3://mybucket-dhans/vlsa123_sync/file_8.txt
# upload: output_20250610_180312\file_5.txt to s3://mybucket-dhans/vlsa123_sync/file_5.txt
# upload: output_20250610_180312\file_9.txt to s3://mybucket-dhans/vlsa123_sync/file_9.txt
# Uploaded files to s3://mybucket-dhans/vlsa123_sync
# Deleted folder output_20250610_180312
