{ pkgs, ... }:

{
  users.users.ryan = {
    isNormalUser = true;
    description = "Ryan";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "input"
    ];
    packages = with pkgs; [

    ];
  };

  users.users.toruser = {
    isSystemUser = false;
    description = "User for tor/ .onion related stuff";
    home = "/home/home/toruser";
    createHome = true;
    shell = pkgs.bashInteractive;
    uid = 1001;
    group = "toruser";
  };

  users.groups.toruser.gid = 1001;

  systemd.tmpfiles.rules = [
    "d /tmp/tmp 0700 toruse toruser - -"
    "d /dev/shm/shm 0700 toruser toruser - -"
    "f /home/home/tor/.bashrc 0600 toruser toruser - umask 0077"
  ];

  environment.etc."firejail/toruser.profile".text = ''
   whitelist /home/home/toruser
   whitelist /tmp/tmp
   whitelist /dev/shm/shm
   whitelist /etc/systemd/resolved.conf
   blacklist /home
   blacklist /tmp
   blacklist /dev/shm
   blacklist /root
   read-only /
   net tor
   dns off
   dbus-system none
   dbus-user none
 '';
}
