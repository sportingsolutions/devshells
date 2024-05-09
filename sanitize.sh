#!/bin/bash

# Define the file path
file="/home/808fsemti/projects/.envrc"
sanitized_file="$(basename "$file")_example"

# Remove sanitized file if it exists in the current directory
if [ -f "$sanitized_file" ]; then
    rm "$sanitized_file"
fi

# Define a regular expression to match text between single or double quotation marks
regex='(".*?"|'\''.*?'\'')'

# Loop through each line in the file
while IFS= read -r line; do
    # Use sed to replace sensitive data with an empty string
    sanitized_line=$(echo "$line" | sed -E "s/$regex/\"\"/g")
    echo "$sanitized_line"
done < "$file" > "$sanitized_file"

# # Move the sanitized file to the current directory
# mv "$sanitized_file" "$(basename "$file")_sanitized"
