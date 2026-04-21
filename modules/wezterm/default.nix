{ config, ... }:

{
  home.file.".config/wezterm/wezterm.lua".source =
    config.lib.file.mkOutOfStoreSymlink "/Users/kosudanaohiro/dotfiles/wezterm.lua";
}
