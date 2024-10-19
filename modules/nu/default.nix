{
  programs.nushell = {
    enable = true;

    extraConfig = ''
      ${builtins.readFile ./config.nu}
      ${builtins.readFile ./aliases.nu}

      ${builtins.readFile ./functions.nu}
    '';

    extraEnv = ''
      ${builtins.readFile ./env.nu}
    '';
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
}
