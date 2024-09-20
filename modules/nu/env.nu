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

if ("/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" | path exists) {
  ^source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
}
if ("$HOME/.nix-profile/etc/profile.d/nix.sh" | path exists) {
  ^source "$HOME/.nix-profile/etc/profile.d/nix.sh"
}

$env.EDITOR = "nvim"
$env.SHELL = "nu"

mkdir ~/.cache/nushell
zoxide init nushell | save -f ~/.cache/nushell/.zoxide.nu
carapace _carapace nushell | save -f ~/.cache/nushell/carapace.nu
atuin init nu | save -f ~/.cache/nushell/atuin.nu
starship init nu | save -f ~/.cache/nushell/starship.nu

