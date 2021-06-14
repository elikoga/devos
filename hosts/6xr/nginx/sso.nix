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
            coafin = "$2y$10$PFnkQT7DLUtIiACVMhqJo.lsrv7dtX2NTJBFV/g4xyNnTdEY1ulsu";
          };
          groups = {
            admins = [ "coafin" ];
          };

        };
      };
    };
  };
}
