#Ask for the configuration file name
read -p "Enter the name for the WireGuard configuration file (e.g., wg0-client.conf): " FILENAME


# Check if the filename is provided
if [ -z "$FILENAME" ]; then
            echo "No filename provided. Exiting script."
                exit 1
fi

# Prompt for input and define variables
read -p "Enter client private key: " CLIENT_PRIVATE_KEY
read -p "Enter client IP address: " CLIENT_IP_ADDRESS
read -p "Enter subnet (e.g., 24): " SUBNET
read -p "Enter client public key: " CLIENT_PUBLIC_KEY
read -p "Enter Website/Lightsail Private IP: " WEBPRIVATE_IP_ADDRESS


# Create WireGuard config file
sudo cat > "$FILENAME" << EOF

[Interface]
PrivateKey = $CLIENT_PRIVATE_KEY
Address = $CLIENT_IP_ADDRESS/$SUBNET
SaveConfig = true

[Peer]
PublicKey = 1c3QwCn0XMagglAq4Tn6JIpqNAlX6JtUAJU9sZgf3X0=
Endpoint = 122.248.229.2:51820
AllowedIPs = $WEBPRIVATE_IP_ADDRESS
EOF

echo "WireGuard client configuration file $FILENAME created."

# Set up WireGuard peer
sudo wg set wg0 peer $CLIENT_PUBLIC_KEY allowed-ips $CLIENT_IP_ADDRESS/32
##########################################################################
echo "WireGuard peer set up completed."

sudo wg
#######################################################
#######################################################

# Ask for the folder name
read -p "Enter the folder name to store the configuration file (leave blank to cancel): " FOLDERNAME

# Check if the folder name was provided
if [ -z "$FOLDERNAME" ]; then
    echo "No folder name provided. Exiting script."
    exit 1
fi

# Define the directory path
DIR="/home/ubuntu/wireguard/client/users_keys/$FOLDERNAME"

# Check if the directory exists, if not create it
if [ ! -d "$DIR" ]; then
    sudo mkdir -p "$DIR"
fi

# Move the configuration file to the specified directory
sudo mv "$FILENAME" "$DIR/"

echo "WireGuard configuration file moved to $DIR/"
