let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | any {|| $in.display | str starts-with "ERR"}) { null } else { $in }
}

let abbreviations = {
  # tools
  vi: "nvim"
  cd: "z"
  top: "btm"
  cat: "bat"
  lss: "eza --icons"
  grep: "rg"
  mm: "mmemo"
  dc: "docker-compose"
  bup: "brew upgrade; brew upgrade --cask --greedy"
  ct: "cargo test"
  ctn: "cargo test -- --nocapture"
  cr: "cargo run --quiet"
  hr: "runghc"
  # git
  gap: "git add -p"
  gba: "git branch -a"
  gsw: "git switch"
  gswb: "git switch -"
  gswc: "git switch -c"
  gcm: "git commit -m"
  gfix: "git commit --amend --no-edit"
  gst: "git status"
  grs: "git restore --staged"
  gfe: "git fetch"
  gre: "git rebase"
  glo: "git log --oneline"
  gpo: "git push origin HEAD"
  gdf: "git diff"
  gdfs: "git diff --staged"
  # jj
  jn: "jj new"
  js: "jj st"
  jl: "jj log"
  jp: "jj split"
  jq: "jj squash"
  jqp: "jj squash --from @-"
  jh: "jj show"
  jd: "jj describe -m"
  jdp: "jj describe -r @- -m"
  jf: "jj diff"
  jfp: "jj diff -r @-"
  jt: "jj tug"
  jgp: "jj git push"
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
      algorithm: "prefix"
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
          max_completion_height: 10,
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
      {
        name: abbr_menu
        only_buffer_difference: false
        marker: ""
        type: {
          layout: columnar
          columns: 1
          col_width: 20
          col_padding: 2
        }
        style: {
          text: green
          selected_text: green_reverse
          description_text: yellow
        }
        source: { |buffer, position|
          let before_cursor = ($buffer | str substring 0..$position)
          let current_word = ($before_cursor | split row ' ' | last)
          let match = $abbreviations | columns | where $it == $current_word
          if ($match | is-empty) {
            { value: $buffer }
          } else {
            let replacement = ($abbreviations | get $match.0)
            let word_len = ($current_word | str length | into int)
            let before_word_end = ($position - $word_len)
            let before_word = if $before_word_end > 0 {
              ($buffer | str substring 0..<$before_word_end)
            } else {
              ''
            }
            let after_cursor = ($buffer | str substring $position..)
            { value: ($before_word ++ $replacement ++ $after_cursor) }
          }
        }
      }
    ]
    keybindings: [
      {
        name: completion_menu
        modifier: none
        keycode: tab
        mode: vi_insert
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
        mode: [vi_insert, vi_normal]
        event: { send: menu name: help_menu }
      }
      {
        name: cancel_command
        modifier: control
        keycode: char_c
        mode: [vi_insert, vi_normal]
        event: { send: ctrlc }
      }
      {
        name: clear_screen
        modifier: control
        keycode: char_q
        mode: [vi_insert, vi_normal]
        event: { send: clearscreen }
      }
      {
        name: move_to_line_end
        modifier: control
        keycode: char_e
        mode: vi_insert
        event: { edit: movetolineend }
      }
      {
        name: move_up
        modifier: control
        keycode: char_p
        mode: [vi_insert, vi_normal]
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
        mode: [vi_insert, vi_normal]
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
        mode: [vi_insert, vi_normal]
        event: { edit: backspaceword }
      }
      # {
      #   name: history_hint_accept
      #   modifier: control
      #   keycode: char_y
      #   mode: vi_insert
      #   event: { send: historyhintcomplete }
      # }
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
        mode: vi_insert
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
        mode: vi_insert
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
        mode: vi_insert
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
        mode: vi_insert
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
        mode: vi_insert
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
      # abbreviations
      {
  name: abbr_enter
  modifier: none
  keycode: enter
  mode: [emacs, vi_normal, vi_insert]
  event: [
    { send: menu name: abbr_menu }
    { send: menunext }
    { send: submit }
  ]
}
      {
        name: accept_abbr
        modifier: control
        keycode: char_y
        mode: [emacs, vi_normal, vi_insert]
        event: [
        { send: HistoryHintComplete }]
      }
      {
  name: abbr_space
  modifier: none
  keycode: space
  mode: [emacs, vi_normal, vi_insert]
  event: [
    { send: menu name: abbr_menu }
    { send: menunext }
    { edit: insertchar value: ' ' }
  ]
}
    ]
}

source ~/.cache/nushell/carapace.nu
source ~/.cache/nushell/atuin.nu
source ~/.cache/nushell/.zoxide.nu

use ~/.cache/nushell/starship.nu
