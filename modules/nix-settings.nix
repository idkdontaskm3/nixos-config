{ ... }:

{
  nix.distributedBuilds = true;

  nix.buildMachines = [
    {
      hostName = "192.168.68.89";
      sshUser = "nix-builder";
      sshKey = "/root/.ssh/nix_builder_key";
      systems = [ "x86_64-linux" ];
      maxJobs = 2;
      speedFactor = 1;
      supportedFeatures = [
        "nixos-test"
        "benchmark"
      ];
      mandatoryFeatures = [ ];
    }
  ];

  nix.settings.builders-use-substitutes = true;
  nix.settings.trusted-users = [ "root" "ryan" ];

  programs.ssh.knownHosts = {
    nixBuilder = {
      hostNames = [ "192.168.68.89" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaJ19mqm12R2dwPGk6rwrPBcEMbCVXcwETNTyEdx/I6 ";
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
}
