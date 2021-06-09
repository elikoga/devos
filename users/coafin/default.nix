{ ssh-keys, pkgs, ... }:
{
  home-manager.users.coafin = { suites, ... }: {
    imports = suites.base;
    programs.bash.bashrcExtra = ''
      shopt -s autocd
    '';
    programs.git = {
      userEmail = "elikowa@gmail.com";
      userName = "Eli Kogan-Wang";
    };
    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
    };
    programs.gpg = {
      enable = true;
    };
    home.packages = with pkgs; [
      neovim
    ];
    systemd.user.sessionVariables = {
      EDITOR = "nvim";
    };
  };

  users.users.coafin = {
    uid = 1000;
    hashedPassword = (import ../../secrets/users/coafin/hashedPasswords.nix).userHashedPassword;
    description = "default";
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "tty" "dialout" ];
    openssh.authorizedKeys.keys = ssh-keys.coafin;
  };

  security.acme = {
    acceptTerms = true;
    email = "elikowa@gmail.com";
    # server = "https://acme-staging-v02.api.letsencrypt.org/directory"; # Makes it go to staging
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    htop
    neovim
    ranger
  ];
}
