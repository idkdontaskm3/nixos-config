{ pkgs, ... }:

{
  services.printing.enable = true;
  hardware.bluetooth.enable = true;
  security.rtkit.enable = true;
  services.fwupd.enable = true;
  services.flatpak.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    acceleration = "vulkan";
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="platform", DRIVERS=="legion-laptop", MODE="0666"
    SUBSYSTEM=="hwmon", ATTRS{name}=="legion_laptop", MODE="0666"
    SUBSYSTEM=="platform", DRIVERS=="ideapad_acpi", MODE="0666"
  '';
}
