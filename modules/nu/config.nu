let dark_theme = {
    separator: white
    leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
    header: green_bold
    empty: blue
    bool: light_cyan
    int: white
    filesize: cyan
    duration: white
    date: purple
    range: white
    float: white
    string: white
    nothing: white
    binary: white
    cell-path: white
    row_index: green_bold
    record: white
    list: white
    block: white
    hints: dark_gray
    search_result: { bg: red fg: white }
    shape_and: purple_bold
    shape_binary: purple_bold
    shape_block: blue_bold
    shape_bool: light_cyan
    shape_closure: green_bold
    shape_custom: green
    shape_datetime: cyan_bold
    shape_directory: cyan
    shape_external: cyan
    shape_externalarg: green_bold
    shape_external_resolved: light_yellow_bold
    shape_filepath: cyan
    shape_flag: blue_bold
    shape_float: purple_bold
    # shapes are used to change the cli syntax highlighting
    shape_garbage: { fg: white bg: red attr: b}
    shape_glob_interpolation: cyan_bold
    shape_globpattern: cyan_bold
    shape_int: purple_bold
    shape_internalcall: cyan_bold
    shape_keyword: cyan_bold
    shape_list: cyan_bold
    shape_literal: blue
    shape_match_pattern: green
    shape_matching_brackets: { attr: u }
    shape_nothing: light_cyan
    shape_operator: yellow
    shape_or: purple_bold
    shape_pipe: purple_bold
    shape_range: yellow_bold
    shape_record: cyan_bold
    shape_redirection: purple_bold
    shape_signature: green_bold
    shape_string: green
    shape_string_interpolation: cyan_bold
    shape_table: blue_bold
    shape_variable: purple
    shape_vardecl: purple
    shape_raw_string: light_purple
}

let alias_completer = {|spans| 
  let expanded_alias = scope aliases
      | where name == $spans.0
      | get -o 0.expansion

  let spans = if $expanded_alias != null {
    $spans
      | skip 1
      | prepend ($expanded_alias | split row ' ' | take 1)
  } else {
    $spans
  }

  carapace $spans.0 nushell ...$spans | from json 
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
				max_results: 100
				completer: $alias_completer
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
            mode: [ emacs vi_normal vi_insert]
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
            name: quit_shell
            modifier: control
            keycode: char_q
            mode: [ vi_insert, vi_normal]
            event: { send: ctrld }
        }
        {
            name: clear_screen
            modifier: control
            keycode: char_z
            mode: [ vi_insert, vi_normal]
            event: { send: clearscreen }
        }
        {
            name: move_to_line_start
            modifier: control
            keycode: char_b
            mode: [ vi_insert, vi_normal]
            event: { edit: movetolinestart }
        }
         {
            name: move_to_line_end
            modifier: control
            keycode: char_f
            mode: [emacs, vi_normal, vi_insert]
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
            mode: [ vi_insert, vi_normal]
            event: { edit: backspace }
        }
				{
            name: move_char_left
            modifier: control
            keycode: char_h
            mode: [ vi_insert, vi_normal ]
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
            mode: [ vi_insert, vi_normal ]
						event: {
							until: [
								{ send: right }
							]
						}
				 }
         {
            name: move_word_left
            modifier: control
            keycode: char_b
            mode: [ vi_insert, vi_normal ]
            event: { edit: movewordleft }
        }
				 {
            name: move_word_right
            modifier: control
            keycode: char_f
            mode: [ vi_insert, vi_normal]
            event: { edit: movewordright }
        }
        {
            name: delete_one_word_backward
            modifier: control
            keycode: char_d
            mode: [ vi_insert, vi_normal]
						event: { edit: backspaceword }
        }
        {
            name: cut_line_from_start
            modifier: control
            keycode: char_u
            mode: "vi_insert"
            event: { edit: cutfromstart }
        }
        
				# autopairs
				 {
						name: autoparen
						modifier: none
						keycode: 'char_('
						mode: [emacs vi_normal vi_insert]
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
						mode: [emacs vi_normal vi_insert]
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
						mode: [emacs vi_normal vi_insert]
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
						mode: [emacs vi_normal vi_insert]
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
						mode: [emacs vi_normal vi_insert]
						event: [ 
								{ edit: InsertChar value: "'" }
								{ edit: InsertChar value: "'" }
								{ edit: MoveLeft }
						]
					}

					# yazi
					{
						name: yazi
						modifier: control
						keycode: char_y
						mode: [emacs vi_normal vi_insert]
						event: [
							{ edit: Clear }
							{ edit: InsertChar value: y }
							{ send: Enter }
						]
					}
    ]
}

source ~/.cache/nushell/carapace.nu
source ~/.cache/nushell/atuin.nu
source ~/.cache/nushell/.zoxide.nu

use ~/.cache/nushell/starship.nu
