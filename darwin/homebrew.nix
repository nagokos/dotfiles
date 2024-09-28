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
      "arc"
      "google-chrome"
      "1password"
      "1password-cli"
      "deepl"
      "wezterm@nightly"
      "notion"
      "orbstack"
      "devtoys"
    ];
  };
}
