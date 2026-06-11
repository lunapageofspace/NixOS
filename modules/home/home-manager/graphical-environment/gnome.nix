{ pkgs, ... }: {
    services.gnome-keyring.enable = true;
    services.gpg-agent.pinentry.package = pkgs.pinentry-gnome3;
    home.packages = with pkgs; [
        dconf2nix
        yubikey-manager-qt
        # Gnome Extensions
        gnomeExtensions.unite
        gnomeExtensions.espresso
        gnomeExtensions.just-perfection
        gnomeExtensions.dash-to-dock
        gnome.gnome-tweaks
        # Resources Themes
        numix-cursor-theme
        tela-icon-theme
    ];
    qt = {
      enable = true;
      platformTheme.name = "adwaita";
      style.name = "adwaita-dark";
    };
}