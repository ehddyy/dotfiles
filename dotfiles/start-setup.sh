#!/usr/bin/env bash
set -euo pipefail
#sudo apt upgrade
#  sudo apt update
#  sudo apt install strongswan libcharon-extra-plugins yubikey-personalization yubico-piv-tool
#  sudo systemctl restart strongswan
# --- Prompt pour installer Nix ---
read -p "Souhaites-tu installer Nix ? (y/n): " install_nix
if [[ "$install_nix" == "y" ]]; then
  echo "Installation de curl si nécessaire..."
  sudo apt update
  sudo apt install -y curl

  echo "Installation de Nix..."
  sh <(curl -L https://nixos.org/nix/install) --daemon
  nix --version

  echo
  echo "⚠️ Pense à ajouter la ligne suivante dans /etc/nix/nix.conf si ce n'est pas déjà fait :"
  echo "experimental-features = nix-command flakes"
  echo
  read -p "Appuie sur [Entrée] quand c'est fait..."

  sudo systemctl restart nix-daemon
fi

# --- Prompt pour installer Home Manager ---
read -p "Souhaites-tu installer Home Manager ? (y/n): " install_hm
if [[ "$install_hm" == "y" ]]; then
  nix profile remove home-manager-path || true
  nix profile add github:nix-community/home-manager
fi

# --- Copier la configuration Home Manager ---
rm -rf "$HOME/.config/home-manager"
cp -r "$HOME/Documents/dotfiles/home-manager" "$HOME/.config/"
rm $HOME/.config/home-manager/flake.lock

# --- Installer i3 ---
read -p "Souhaites-tu installer i3 ? (y/n): " install_i3
if [[ "$install_i3" == "y" ]]; then
  sudo apt install -y i3
fi

home-manager switch

# --- Droits d'accès sur scripts et clés ---
sudo chmod +x "$HOME/Documents/dotfiles/i3blocks"/*
#chmod 400 "$HOME/.ssh/id_*" || true

# --- Définir ZSH comme shell par défaut ---
command -v zsh | sudo tee -a /etc/shells
sudo chsh -s "$(which zsh)" "$USER"

# --- Configurer npm ---
mkdir -p ~/.npm-global/lib
npm config set prefix '~/.npm-global'
npm install -g @marp-team/marp-cli

# --- Installer Docker ---
sudo apt install -y docker.io

# --- Installer gcc et build-essential ---
sudo apt-get update
sudo apt-get install -y build-essential libpq-dev

# --- Lancer ZSH ---
exec zsh
echo "end"
