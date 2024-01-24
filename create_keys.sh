#!/bin/bash

# Function to generate WireGuard keys and move them to a specific folder
generate_and_move_keys() {
    local folder_name=$1

    # Generate WireGuard keys
   sudo wg genkey | tee privatekey | wg pubkey > publickey

    # Create the specified folder if it doesn't exist
    sudo mkdir -p "$folder_name"

    # Move the keys to the specified folder
    sudo mv privatekey publickey "$folder_name/"

    echo "Keys generated and moved to $folder_name"
}

# Main script starts here

# Ask for the folder name
read -p "Enter the name of the folder to store the keys: " folder_name

# Call the function with the user-provided folder name
generate_and_move_keys "$folder_name"

# Show the results
echo "Contents of the $folder_name folder:"
ls -l "$folder_name"
