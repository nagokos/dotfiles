use std

def --env fg [] {
  let workdir = ghq list -p | fzf | decode utf-8 | str trim
  cd $workdir
}

def myip [] {
    curl -s ipinfo.io/what-is-my-ip | from json
}
