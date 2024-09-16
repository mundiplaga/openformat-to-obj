#!/bin/bash

# List of expected files
files=("accs_000_u" "berd_000_u" "hair_000_u" "head_000_r" "lowr_000_u" "uppr_000_r")

# Bring up all containers
docker-compose up --build

# Store MD5 sums for Python 3.12
declare -A md5sums_3_12

# Loop over Python versions
for version in 3.12 3.11 3.10 3.9 3.8 3.7 3.6 3.5 3.4; do
  echo "Checking output for Python $version..."

  # Loop over each file in the list
  for file in "${files[@]}"; do
    # Check for .obj file
    if [ -f "./output/python$version/$file.obj" ]; then
      echo "$file.obj found for Python $version"
    else
      echo "$file.obj not found for Python $version!"
      exit 1
    fi

    # Check for .mtl file
    if [ -f "./output/python$version/$file.mtl" ]; then
      echo "$file.mtl found for Python $version"
    else
      echo "$file.mtl not found for Python $version!"
      exit 1
    fi

    # Calculate MD5 sum for .obj and .mtl files
    obj_md5=$(md5sum "./output/python$version/$file.obj" | awk '{ print $1 }')
    mtl_md5=$(md5sum "./output/python$version/$file.mtl" | awk '{ print $1 }')

    # If we are on Python 3.12, store the MD5 sums
    if [ "$version" == "3.12" ]; then
      md5sums_3_12["$file.obj"]=$obj_md5
      md5sums_3_12["$file.mtl"]=$mtl_md5
    else
      # For other versions, compare with Python 3.12 hashes
      if [ "$obj_md5" != "${md5sums_3_12["$file.obj"]}" ]; then
        echo "MD5 mismatch for $file.obj between Python 3.12 and Python $version!"
        exit 1
      fi

      if [ "$mtl_md5" != "${md5sums_3_12["$file.mtl"]}" ]; then
        echo "MD5 mismatch for $file.mtl between Python 3.12 and Python $version!"
        exit 1
      fi
    fi
  done
done

echo "All files have matching MD5sums across versions."

# Clean up containers after testing
docker-compose down
