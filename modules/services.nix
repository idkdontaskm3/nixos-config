{ pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  security.rtkit.enable = true;
  services.fwupd.enable = true;
  services.flatpak.enable = true;

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNS = [
        "45.90.28.0#19ef84.dns.nextdns.io"
        "2a07:a8c0::#19ef84.dns.nextdns.io"
        "45.90.30.0#19ef84.dns.nextdns.io"
        "2a07:a8c1::#19ef84.dns.nextdns.io"
      ];
      DNSOverTLS = "yes";
    };
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      hplip
      gutenprint
      brlaser
      splix
    ];
  };

  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        settings = {
          main = {
            capslock = "esc";
            esc = "capslock";
          };
        };
      };
    };
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="platform", DRIVERS=="legion-laptop", MODE="0666"
    SUBSYSTEM=="hwmon", ATTRS{name}=="legion_laptop", MODE="0666"
    SUBSYSTEM=="platform", DRIVERS=="ideapad_acpi", MODE="0666"
  '';
}
