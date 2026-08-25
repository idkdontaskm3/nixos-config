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

# users.users.tor = {
#   isSystemUser = false;
#   description = "User for tor/ .onion related stuff";
#   home = "/home/home/tor";
#   createHome = true;
#   shell = pkgs.nologin;
#   uid = 1001;
#   group = "tor";
#   umask = "0077";
# };

# users.groups.tor.gid = 1001;

# systemd.tmpfiles.rules = [
#   "d /tmp/tmp 0700 tor tor - -"
#   "d /dev/shm/shm 0700 tor tor - -"
# ];

# environment.etc."firejail/tor.profile".text = ''
#   whitelist /home/home/tor
#   whitelist /tmp/tmp
#   whitelist /dev/shm/shm
#   whitelist /etc/systemd/resolved.conf
#   blacklist /home
#   blacklist /tmp
#   blacklist /dev/shm
#   blacklist /root
#   read-only /
#   net tor
#   dns off
#   dbus-system none
#   dbus-user none
# '';
}
