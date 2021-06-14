{ suites, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./nginx
  ] ++ suites.base;

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  services.fail2ban.enable = true;
  services.netdata.enable = true;
  networking.useDHCP = false;
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  networking.interfaces.ens18.useDHCP = true;
  networking.hostName = "6xr.de";

  services.hydra.enable = true;
  services.hydra.hydraURL = "hydra.6xr.de";
  services.hydra.notificationSender = "hydra@6xr.de";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
