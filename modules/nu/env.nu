# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
		"PATH": {
				from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
				to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
		}
		"Path": {
				from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
				to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
		}
}

$env.SHELL = "nu"
$env.STARSHIP_SHELL = "nu"
$env.STARSHIP_CONFIG = ($nu.home-path | path join "modules" "starship" "starship.toml")

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.PROMPT_MULTILINE_INDICATOR = ""

$env.PATH = ($env.PATH | split row (char esep) | prepend [
  '~/.nix-profile/bin'
  '/nix/var/nix/profiles/default/bin'
])

# $env.FZF_DEFAULT_OPTS = [
#     "--height 50%"
#     "--layout=reverse"
#     "--border"
#     "--preview-window 'right:50%'"
#     "--bind 'ctrl-/:change-preview-window(80%|hidden|)'"
#     "--bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'"
# ] | str join " "

mkdir ~/.cache/nushell
zoxide init nushell | save -f ~/.cache/nushell/.zoxide.nu
carapace _carapace nushell | save -f ~/.cache/nushell/carapace.nu
atuin init nu | save -f ~/.cache/nushell/atuin.nu
starship init nu | save -f ~/.cache/nushell/starship.nu
