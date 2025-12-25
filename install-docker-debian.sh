#!/usr/bin/env bash
set -e

# -----------------------------
# Docker installation script
# for Debian (official method)
# -----------------------------

if [[ $EUID -ne 0 ]]; then
  echo "❌ Please run as root (use sudo)"
  exit 1
fi

echo "🧹 Removing old Docker versions (if any)..."
apt-get remove -y docker docker-engine docker.io containerd runc || true

echo "🔄 Updating package index..."
apt-get update

echo "📦 Installing required dependencies..."
apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

echo "🔐 Adding Docker official GPG key..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg \
  | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo "📦 Adding Docker APT repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" \
  > /etc/apt/sources.list.d/docker.list

echo "🔄 Updating package index (Docker repo)..."
apt-get update

echo "🐳 Installing Docker Engine and plugins..."
apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

echo "🚀 Enabling Docker service..."
systemctl enable docker
systemctl start docker

echo "👤 Adding current user to docker group..."
if id "${SUDO_USER:-}" &>/dev/null; then
  usermod -aG docker "$SUDO_USER"
  echo "⚠️  Log out and log back in to use Docker without sudo."
fi

echo "✅ Docker installation complete!"
echo
echo "📌 Versions:"
docker --version
docker compose version
