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
      "zoom"
      "raycast"
      "google-chrome"
      "1password"
      "1password-cli"
      "deepl"
      "slack"
      "obsidian"
      "discord"
      "notion"
      "orbstack"
      "devtoys"
      "claude"
      "chatgpt"
      "firefox"
      "wezterm@nightly"
    ];
  };
}
