{
  # https://github.com/NixOS/nixpkgs/issues/239384
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };
}
