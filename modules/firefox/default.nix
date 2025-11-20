{ pkgs, inputs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        name = "main";
        extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
          ublock-origin
          tree-style-tab
        ];
      };
    };
  };
}
