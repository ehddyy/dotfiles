{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # Outils spécifiques à Linux (environnement X/Wayland, gestionnaire de fenêtres, etc.)
    acpi # Pour les informations d'alimentation (ne fonctionne pas sur macOS)
    autorandr # Gestion de la configuration d'écran (typiquement X/Linux)
    i3 # Gestionnaire de fenêtres (Linux uniquement)
    i3blocks
    wmctrl # Pour gérer les fenêtres (typiquement X/Linux)
    pamixer # Pour le volume (utilise PulseAudio/PipeWire, Linux)
    rofi
    xclip # Gestion du presse-papier X (Linux)
    # Laissez ici les paquets commentés si vous les utilisez sur Linux :
    # conda
    # mysql
    # ollama        # Le service est systemd.user.services.ollama
    blueman # Bluetooth client manager
  ];

  # Service Ollama (spécifique à systemd/Linux)
  systemd.user.services.ollama = {
    Unit = {
      Description = "Ollama Service";
      After = "network-online.target";
    };
    Install = {
      # WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.ollama}/bin/ollama serve";
      Restart = "always";
      RestartSec = "3";
      Environment = "PATH=${pkgs.ollama}/bin:$PATH";
    };
  };

}
