# NixOS and HomeManager Configuration

## Upgrading

```shell
sudo nix flake update
sudo nixos-rebuild boot --flake .
```

On the raspberry pi, the system firmware and bootloader can be updated using `sudo rpi-eeprom-update -d -a`

## Systems

### Ephemera

Ephemera is nixosSystem meant to be used without networking functions enabled for the purposes of generating and signing cryptographic certificates in an air-gapped environment.

To build the image execute `nix build .#nixosConfigurations.ephemera.config.system.build.isoImage`.

## Full Disk Encryption

Enrolling the fido2 device with `systemd-cryptenroll`

```shell
sudo systemd-cryptenroll --fido2-device=auto /dev/device
```

Unlocking with `systemd-cryptsetup`

```shell
sudo systemd-cryptsetup attach device-mapper-name /dev/device - fido2-device=auto
```

Need to configure the initramdisk to include systemd and look for a fido2 device, add this to the system configuration:

```
boot.initrd.systemd.enable = true;
boot.initrd.luks.devices."device-mapper-name".crypttabExtraOpts = [ "fido2-device=auto" ];
```
