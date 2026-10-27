{
  lib,
  ...
}:
{
  den.aspects.preset.nixos = {
    nixos = {
      # Bootloader defaults
      boot = {
        loader = {
          limine.enable = true;
        };
        tmp.cleanOnBoot = lib.mkDefault true;
      };

      # Networking configuration (mirroring DNS from preset.darwin)
      networking = {
        networkmanager.enable = true;
        nameservers = [
          "1.1.1.1"
          "1.0.0.1"
          "2606:4700:4700::1111"
          "2606:4700:4700::1001"
        ];
        firewall.enable = true;
      };

      # Sound / Audio with PipeWire
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      # Security & Polkit
      security.polkit.enable = true;

      # Hardware & Graphics acceleration
      hardware = {
        bluetooth = {
          enable = true;
          powerOnBoot = false;
        };
      };

      # Power management & SSD TRIM
      services.fstrim.enable = lib.mkDefault true;

      # System fonts
      fonts.fontconfig.enable = lib.mkDefault true;
    };
  };
}
