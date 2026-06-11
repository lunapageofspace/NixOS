
{ config, lib, inputs, pkgs, ... }: {
    imports = [
        ./filesystems.nix
        ./syncthing.nix
        ./sshcerts.nix
        ./moonlander.nix
    ];

    # Include AMD Microcode
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    # Include wifi firmware, among other things
    hardware.enableRedistributableFirmware = true;

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    boot.extraModulePackages = [ ];

    # Use the systemd-boot EFI boot loader.
    boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };

    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    programs.nix-ld.enable = true;

    services.ivpn.enable = true;

    environment.systemPackages = with pkgs; [
      ivpn
      icu
      zulu17 # Java Runtime 17 ( Starsector )
      gamemode
      gamescope
      protonup-qt
      r2modman-upstream
      steamtinkerlaunch
      (lutris.override {
        extraLibraries =  pkgs: [
          # List library dependencies here
        ];
        extraPkgs = pkgs: [
          # List package dependencies here
        ];
      })
      # overrides the NixOS package, starsector, see: https://wiki.nixos.org/wiki/Starsector
      (pkgs.starsector.overrideAttrs ({ ... }: {
        #postInstall = ''
        #  cp ${dotfiles/starsector/settings.json} $out/share/starsector/data/config/settings.json
        #  substituteInPlace $out/share/starsector/.starsector.sh-wrapped \
        #    --replace-fail "Xms1536m" "Xms8192m" \
        #    --replace-fail "Xmx1536m" "Xmx8192m"
        #'';
      }))
    ];

    programs.winbox = {
        enable = true;
        openFirewall = true;
        package = pkgs.winbox;
    };

    networking.firewall = {
      allowedTCPPorts = [ 80 443 42420 ];
      allowedUDPPorts = [ 42420 ];
      allowedUDPPortRanges = [
        {
          from = 40000;
          to = 50000;
        }
      ];
    };

    # Fancy boot graphics
    boot.plymouth = {
        enable = true;
        #themePackages = [self'.packages.catppuccin-plymouth];
        #theme = "mocha";
    };
}
