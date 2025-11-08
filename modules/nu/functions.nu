use std

def _create_bar [percentage: int]: nothing -> string {
    let max_length = 20   # Length of the bar
    let filled_length = ($max_length * $percentage / 100) | into int

    let filled_bar =  "█" | std repeat $filled_length | str join
    let empty_bar =  "░" | std repeat ($max_length - $filled_length) | str join
    let bar = $filled_bar + $empty_bar
    $bar
}

def _into-filesize [in_half_kb]: nothing -> filesize {
    let f_size = $in_half_kb * 512 |  into filesize 
    $f_size
}

def df [] {
    ^df -Y | jc --df | from json |
    | update 512_blocks { |row| _into-filesize $row.512_blocks }
    | update used { |row| _into-filesize $row.used }
    | update available { |row| _into-filesize $row.available }
    | insert capacity_bar { |row| _create_bar $row.capacity_percent}
    | rename -c {capacity_percent: "capacity (%)"}
    | rename -c {iused_percent: "iused (%)"}
}

def whatismyip [] {
    curl -s ipinfo.io/what-is-my-ip | from json
}
