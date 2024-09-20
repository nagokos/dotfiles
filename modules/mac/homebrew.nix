{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    global = {
      brewfile = true;
      lockfiles = false;
    };
    casks = [
      "google-chrome"
      "1password"
      "1password-cli"
      "docker"
      "zoom"
      "deepl"
      "wezterm@nightly"
      "notion"
      "orbstack"
      "devtoys"
      "font-jetbrains-mono-nerd-font"
    ];
  };
}
