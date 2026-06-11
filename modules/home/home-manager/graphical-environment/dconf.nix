{ hardware, lib, ...}:
let
    hypervisor = builtins.hasAttr "hypervisor" hardware && hardware.hypervisor;
in
{
    config = (lib.mkMerge [
        {
            # Common dconf settings
            dconf.settings = {
                "org/gnome/desktop/interface" = {
                    monospace-font-name = "CaskaydiaCove Nerd Font Mono 10";
                    show-battery-percentage = true;
                    color-scheme = "prefer-dark";
                    locate-pointer = true;
                };
                "org/gnome/desktop/peripherals/touchpad" = {
                    two-finger-scrolling-enabled = true;
                    tap-to-click = true;
                };
                "org/gnome/desktop/wm/preferences" = {
                    button-layout = "appmenu:minimize,maximize,close";
                };
            };
        }
        #lib.mkIf (hypervisor) {
        #    # Configure default libvirt settings
        #    dconf.settings = {
        #        "org/virt-manager/virt-manager/connections" = {
        #            uris = ["quemu://system"];
        #            autoconnect = ["quemu:///system"];
        #        };
        #        "org/virt-manager/virt-manager/confirm" = {
        #            unapplied-dev  = true;
        #            delete-storage = false;
        #            forcepoweroff  = false;
        #            removedev      = false;
        #        };
        #    };
        #}
    ]);
}


