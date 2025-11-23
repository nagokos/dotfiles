{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        name = "main";
        extensions = {
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            vimium
            onepassword-password-manager
            multi-account-containers
          ];
        };
      };
    };
  };
}
