let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | any {|| $in.display | str starts-with "ERR"}) { null } else { $in }
}

$env.config = {
		show_banner: false,
		history: {
			max_size: 100_000
			sync_on_enter: true
			file_format: "plaintext"
			isolation: false
		}
		completions: {
			case_sensitive: false
			quick: false
			partial: true
			algorithm:  "prefix"
			external: {
				enable: true
				completer: $carapace_completer
			}
			use_ls_colors: true
		}
   edit_mode: vi
	 shell_integration: {
			osc2: true
			osc7: true
			osc8: true
			osc9_9: true
			osc133: false
			osc633: true
			reset_application_mode: true
    }
		menus: [
        {
					name: completion_menu
					only_buffer_difference: false
					marker: ""
					type: {
							layout: ide
							min_completion_width: 0,
							max_completion_width: 50,
							max_completion_height: 10, # will be limited by the available lines in the terminal
							padding: 0,
							border: true,
							cursor_offset: 0,
							description_mode: "prefer_right"
							min_description_width: 0
							max_description_width: 50
							max_description_height: 10
							description_offset: 1
							correct_cursor_pos: false
					}
					style: {
							text: green
							selected_text: { attr: r }
							description_text: yellow
							match_text: { attr: u }
							selected_match_text: { attr: ur }
					}
        }
    ]
		keybindings: [
	    	# https://github.com/atuinsh/atuin/issues/1392
        {
            name: completion_menu
            modifier: none
            keycode: tab
            mode:  vi_insert
            event: {
                until: [
                    { send: menu name: completion_menu }
                    { send: menunext }
                    { edit: complete }
                ]
            }
        }
        {
            name: help_menu
            modifier: none
            keycode: f1
            mode: [ vi_insert, vi_normal]
            event: { send: menu name: help_menu }
        }
        {
            name: cancel_command
            modifier: control
            keycode: char_c
            mode: [ vi_insert, vi_normal]
            event: { send: ctrlc }
        }
        {
            name: clear_screen
            modifier: control
            keycode: char_q
            mode: [ vi_insert, vi_normal]
            event: { send: clearscreen }
        }
         {
            name: move_to_line_end
            modifier: control
            keycode: char_e
            mode:  vi_insert
            event: { edit: movetolineend }
        }
        {
            name: move_up
            modifier: control
            keycode: char_p
            mode: [ vi_insert, vi_normal]
            event: {
                until: [
                    { send: menuup }
                    { send: up }
                ]
            }
        }
				{
						name: move_down
						modifier: control
						keycode: char_n
						mode: [ vi_insert, vi_normal]
						event: {
								until: [
										{ send: menudown }
										{ send: down }
								]
						}
				}
        {
            name: delete_one_character_backward
            modifier: none
            keycode: backspace
            mode: vi_insert
            event: { edit: backspace }
        }
				{
            name: move_char_left
            modifier: control
            keycode: char_h
            mode: vi_insert
						event: {
							until: [
								{ send: left }
							]
						}
        }
				{
            name: move_char_right
            modifier: control
            keycode: char_l
            mode: vi_insert 
						event: { send: right }
				 }
        {
            name: delete_one_word_backward
            modifier: control
            keycode: char_d
            mode: [ vi_insert, vi_normal]
						event: { edit: backspaceword }
        }
        {
          name: history_hint_accept
          modifier: control
          keycode: char_y
          mode: vi_insert
          event: { send: historyhintcomplete }
        }
        {
          name: vi_switch_normal
          modifier: control
          keycode: "char_["
          mode: vi_insert
          event: {
            send: vichangemode
            mode: normal
          }
        }
				# autopairs
				 {
						name: autoparen
						modifier: none
						keycode: 'char_('
						mode:  vi_insert
						event: [ 
								{ edit: InsertChar value: "(" }
								{ edit: InsertChar value: ")" }
								{ edit: MoveLeft }
						]
					}
				 {
						name: autoparen
						modifier: none
						keycode: 'char_{'
						mode:  vi_insert
						event: [ 
								{ edit: InsertChar value: "{" }
								{ edit: InsertChar value: "}" }
								{ edit: MoveLeft }
						]
					}
				 {
						name: autoparen
						modifier: none
						keycode: 'char_['
						mode:  vi_insert
						event: [ 
								{ edit: InsertChar value: "[" }
								{ edit: InsertChar value: "]" }
								{ edit: MoveLeft }
						]
					}
				 {
						name: autoparen
						modifier: none
						keycode: 'char_"'
						mode:  vi_insert
						event: [ 
								{ edit: InsertChar value: '"' }
								{ edit: InsertChar value: '"' }
								{ edit: MoveLeft }
						]
					}
					{
						name: autoparen
						modifier: none
						keycode: "char_'"
						mode:  vi_insert
						event: [ 
								{ edit: InsertChar value: "'" }
								{ edit: InsertChar value: "'" }
								{ edit: MoveLeft }
						]
					}

					# fzf
					{
						name: fzf
						modifier: control
						keycode: char_f
						mode: [vi_normal vi_insert]
						event: [
							{ edit: Clear }
							{ edit: InsertString value: "fzf" }
							{ send: Enter }
						]
					}
    ]
}

source ~/.cache/nushell/carapace.nu
# BUG: https://github.com/atuinsh/atuin/issues/2900
source ~/.cache/nushell/atuin.nu
source ~/.cache/nushell/.zoxide.nu

use ~/.cache/nushell/starship.nu
