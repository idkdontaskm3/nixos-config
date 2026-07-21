{ ... }:

{
  security.protectKernelImage = true;
  security.unprivilegedUsernsClone = false;
  security.apparmor.enable = true;
  security.apparmor.killUnconfinedConfinables = true;
  security.forcePageTableIsolation = true;
  systemd.services.apparmor.reloadTriggers = [];

  boot.kernel.sysctl = {
    "kernel.kptr_restrict" = 2;
    "kernel.dmesg_restrict" = 1;
    "net.core.bpf_jit_harden" = 2;
    "fs.protected_hardlinks" = 1;
    "fs.protected_symlinks" = 1;
  };

  networking.firewall = {
    enable = true;
    allowPing = false;
    logRefusedConnections = false;
  };
}
