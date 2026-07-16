{ ... }:

{
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4 * 1024;
    }
  ];

  zramSwap = {
    enable = true;
    priority = 50;
    memoryPercent = 15;
  };
}
