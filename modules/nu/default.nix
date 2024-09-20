{
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;

    extraConfig = ''
            			${builtins.readFile ./env.nu}
                  ${builtins.readFile ./aliases.nu}
      						$env.PATH = ($env.PATH | split row (char esep) | prepend [
            "/run/current-system/sw/bin"
            "$HOME/.nix-profile/bin"
            "/nix/var/nix/profiles/default/bin"
            "/run/current-system/sw/bin"
          ] | uniq)
    '';
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  # manually create starship init
  xdg.configFile."nushell/starship.nu".source = ./starship_init.nu;

  # generate by `starship preset nerd-font-symbols -o ./starship.toml`
  xdg.configFile."starship.toml".source = ./starship.toml;
}
