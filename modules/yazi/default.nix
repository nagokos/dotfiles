{ pkgs, ... }:
let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "19dc890e33b8922eb1a3a165e685436ec4ac0a59";
    hash = "sha256-Hml7n07G6tEOPUPOFN9jf01C5LtZRO8pfERVHKHJQRo=";
  };
in
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

    settings = {
      mgr = {
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
