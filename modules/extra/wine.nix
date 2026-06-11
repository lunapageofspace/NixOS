{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        winetricks
        wineWowPackages.stable
        wineWowPackages.waylandFull
        eden.packages.${pkgs.system}.eden
    ];
}