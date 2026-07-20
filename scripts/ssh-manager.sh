#!/usr/bin/env bash
# =============================================================================
# SSH Config Manager
# -----------------------------------------------------------------------------
# A small interactive helper that adds a new server entry to your SSH config
# (~/.ssh/config). It uses "gum" for a friendly terminal UI and collects the
# host alias, IP/hostname, SSH user, and PEM key path, then appends a ready-to-
# use "Host" block so you can connect with:  ssh <alias>
# =============================================================================

# Define the SSH config file path
SSH_DIR="$HOME/.ssh"
SSH_CONFIG="$SSH_DIR/config"

# Check if gum is installed
if ! command -v gum &> /dev/null; then
    echo -e "\033[31mError: 'gum' is not installed.\033[0m"
    echo "Please install it first: https://github.com/charmbracelet/gum#installation"
    exit 1
fi

# Clear screen for a clean UI experience
clear

# Render a beautiful header
gum style \
    --foreground 212 --border-foreground 212 --border double \
    --align center --width 50 --margin "1 2" --padding "1 2" \
    "🚀 SSH Config Manager"

gum style --foreground 240 "Let's add a new server to your ~/.ssh/config"
echo ""

# 1. Prompt for the Host Alias
HOST_ALIAS=$(gum input --prompt "🖥️  Host Alias (e.g., prod-db): " --placeholder "prod-db")
if [ -z "$HOST_ALIAS" ]; then
    gum style --foreground 196 "Host alias is required. Exiting."
    exit 1
fi

# 2. Prompt for the IP Address / HostName
HOST_IP=$(gum input --prompt "🌐 IP Address / Hostname: " --placeholder "192.168.1.10")
if [ -z "$HOST_IP" ]; then
    gum style --foreground 196 "IP Address is required. Exiting."
    exit 1
fi

# 3. Prompt for the User (Defaults to ubuntu)
SSH_USER=$(gum input --prompt "👤 SSH User (default: ubuntu): " --placeholder "ubuntu")
SSH_USER=${SSH_USER:-ubuntu}

# 4. Prompt for the PEM / Identity File (Defaults to your specific Windows path)
DEFAULT_PEM='C:\Users\Pratik\Desktop\admin.pem'
PEM_FILE=$(gum input --prompt "🔑 PEM File Path (default: admin.pem): " --placeholder "$DEFAULT_PEM")
PEM_FILE=${PEM_FILE:-$DEFAULT_PEM}

# Render a summary box of the inputs
gum style \
    --foreground 82 --border-foreground 82 --border rounded \
    --padding "1 2" --margin "1 2" \
    "Configuration Details:
Host: $HOST_ALIAS
HostName: $HOST_IP
User: $SSH_USER
IdentityFile: $PEM_FILE"

# Confirm with the user before writing to the file
if gum confirm "Does this look correct and ready to append?"; then
    
    # Ensure the .ssh directory exists with correct permissions
    mkdir -p "$SSH_DIR"
    chmod 700 "$SSH_DIR"

    # Use a spinner for a polished, functional delay
    gum spin --spinner dot --title "Appending to $SSH_CONFIG..." -- sleep 1

    # Append the configuration
    # Note: Double quotes around $PEM_FILE ensure Windows paths with spaces won't break the SSH config
    cat <<EOF >> "$SSH_CONFIG"

# Added by SSH Config Manager
Host $HOST_ALIAS
    HostName $HOST_IP
    User $SSH_USER
    IdentityFile "$PEM_FILE"
EOF
    
    # Ensure the config file has the strict permissions SSH requires
    chmod 600 "$SSH_CONFIG"

    echo ""
    gum style --foreground 212 "✨ Successfully added '$HOST_ALIAS' to $SSH_CONFIG!"
else
    echo ""
    gum style --foreground 196 "Aborted. No changes were made."
fi