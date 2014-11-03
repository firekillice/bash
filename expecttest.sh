#!/usr/bin/expect -f

set USER linghegu
set PHRASE bornfish
set SERVER_HOST [lindex $argv 0]

catch {spawn ssh -l $USER $SERVER_HOST}
expect {
    "*yes/no*" { send "yes\r" }
    "*passphrase*" { send "$PHRASE\r" }
}
