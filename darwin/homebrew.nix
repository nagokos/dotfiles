{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    global = {
      brewfile = true;
      lockfiles = false;
    };
    casks = [
      "raycast"
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
