{ inputs, config, pkgs, ... }:
let
  homeDirectory = config.home.homeDirectory;
in
{
  xdg.configFile.nvim.source = "${homeDirectory}/modules/nvim";
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;


    plugins = with pkgs.vimPlugins; [
      lz-n
    ];
  };
}
