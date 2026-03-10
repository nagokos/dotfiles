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
    };
    casks = [
      "zoom"
      "raycast"
      "google-chrome"
      "1password"
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
