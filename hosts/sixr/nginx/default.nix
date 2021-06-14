{ ... }:
{
  imports = [
    ./sso.nix
  ];
  services.nginx = {
    enable = true;
    virtualHosts = {
      "login.6xr.de" = {
        addSSL = true;
        enableACME = true;
        locations = {
          "/" = {
            proxyPass = "http://localhost:8082";
          };
        };
      };
      "6xr.de" = {
        default = true;
        addSSL = true;
        enableACME = true;
        locations = {
          "/netdata" = { return = "301 /netdata/"; };
          "/netdata/" = {
            proxyPass = "http://localhost:19999/";
            extraConfig = ''
              auth_request /sso-auth;
              auth_request_set $cookie $upstream_http_set_cookie;
              add_header Set-Cookie $cookie;
            '';
          };
          "/sso-auth" = {
            proxyPass = "http://localhost:8082/auth";
            extraConfig = ''
              proxy_pass_request_body off;
              proxy_set_header Content-Length "";
              proxy_set_header X-Origin-URI $request_uri;
              proxy_set_header X-Host $http_host;
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Forwarded-Proto $scheme;
              proxy_set_header X-Application "net";
            '';
          };
          "/sso-logout" = {
            return = "302 https://login.6xr.de/logout?go=$scheme://$http_host/";
          };
          "@error401" = {
            return = "302 https://login.6xr.de/login?go=$scheme://$http_host$request_uri";
          };
        };
        extraConfig = ''
          error_page 401 = @error401;
        '';
      };
    };
    recommendedProxySettings = true;

  };
}
