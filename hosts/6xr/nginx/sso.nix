{ self, ... }:
{
  services.nginx.sso = {
    enable = true;
    configuration = {
      login = {
        title = "This is a restricted service, please log in.";
        default_method = "simple";
        default_redirect = "https://6xr.de/";
        names = {
          simple = "Username / Password";
        };
      };
      cookie = {
        domain = ".6xr.de";
        authentification_key = "Ff1uWJcLouKu9kwxgbnKcU3ps47gps72sxEz79TGHFCpJNCPtiZAFDisM4MWbstH";
        secure = true;
      };
      acl = {
        rule_sets = [
          {
            rules = [ ];
            allow = [ "coafin" ];
          }
        ];
      };
      providers = {
        simple = {
          enable_basic_auth = true;
          users = {
            coafin = (import "${self}/secrets/users/coafin/hashedPasswords.nix").nginxSSOHashedPassword;
          };
          groups = {
            admins = [ "coafin" ];
          };

        };
      };
    };
  };
}
