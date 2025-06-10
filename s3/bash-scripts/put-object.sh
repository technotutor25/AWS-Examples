if [ -z "$1" ]; then
    echo "Usage: $0 <bucket-name> <prefix>"
    exit 1
fi
bucket_name="$1"  # Replace with your bucket name
PREFIX="$2"

output_dir="output"
mkdir -p "$output_dir"
timestamp=$(date +%Y%m%d%H%M%S)
random_file="$output_dir/file_${timestamp}_$RANDOM.txt"
echo "This is a random file generated at $timestamp" > "$random_file"
echo "Random file created: $random_file"

aws s3api put-object --bucket "$bucket_name" --key "$PREFIX/$(basename "$random_file")" --body "$random_file"
echo "Uploaded file to s3://$bucket_name/$PREFIX/$(basename "$random_file") using s3api put-object"

# Clean up the local file
rm -f "$random_file"
echo "Deleted local file $random_file"

aws s3 sync "s3://$bucket_name/$PREFIX" "$output_dir/"
echo "Synced files from s3://$bucket_name/$PREFIX to $output_dir/"