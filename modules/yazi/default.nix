{ pkgs, ... }:
let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "4f1d0ae0862f464e08f208f1807fcafcd8778e16";
    sha256 = "1yr1p14xyfx4bj4dz7as1g2f8h1dwv0x1izvnbffr85zgbmc7ppr";
  };
in
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

    settings = {
      manager = {
        show_hidden = true;
      };
      preview = {
        max_width = 1000;
        max_height = 1000;
      };
      plugin.prepend_fetchers = [
        {
          id = "git";
          name = "*";
          run = "git";
        }
        {
          id = "git";
          name = "*/";
          run = "git";
        }
      ];
    };

    plugins = {
      full-border = "${yazi-plugins}/full-border.yazi";
      max-preview = "${yazi-plugins}/max-preview.yazi";
      git = "${yazi-plugins}/git.yazi";
    };

    initLua = ''
      require("full-border"):setup()
      require("git"):setup()
    '';
  };

  xdg.configFile."yazi/keymap.toml".source = ./keymap.toml;
}
