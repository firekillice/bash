#!/usr/bin/expect -f
# $ serverhost serverport user phase remotefilepath localfilepath


set SERVER_HOST [lindex $argv 0]
set SERVER_PORT [lindex $argv 1]
set USER [lindex $argv 2]
set KEYFILE [lindex $argv 3]
set PHASE [lindex $argv 4]
set REMOTE_FILEPATH [lindex $argv 5]
set LOCAL_FILEPATH [lindex $argv 6]

catch {spawn scp -P $SERVER_PORT -i $KEYFILE $USER@$SERVER_HOST:$REMOTE_FILEPATH  $LOCAL_FILEPATH}
expect {
    "*yes/no*" { send "yes\r" }
    "*passphrase*" { send "$PHASE\r" }
}
expect "100%"
expect eof


# scp -P 36000 -i ~/.ssh/key.file linghegu@203.195.155.241:/data/gamelogs/core/zone.tar.gz .
