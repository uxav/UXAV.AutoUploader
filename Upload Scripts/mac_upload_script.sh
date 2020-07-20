#!/usr/bin/env bash

# This assumes use of existing installed ssh key on device for the username!

# Set the SSH config host value here (see below for example config)
sshHost='mc4'

# Set the program slot here
programSlot=1

# Example SSH Config in ~/.ssh/config
#
# ----------------------------
# Host mc4
# 	HostName mc4.hq.ux.digital
#	User yourusername
#	PreferredAuthentications publickey
#	IdentityFile /Users/yourusername/.ssh/sshkey
#	UseKeychain yes
#	AddKeysToAgent yes
# ----------------------------

# Print file and host to output
echo "Uploading $1 ... to \"$sshHost\""

# Open SFTP connection to processor and put the file
sftp ${sshHost}:/program01 << EOF
put $1
exit
EOF

echo "Uploaded, will now ssh to processor and run ..."

# Open SSH connection to processor and restart the program
ssh -t -t ${sshHost} << EOF
progload -P:${programSlot}
bye
EOF

echo "Disconnected. Complete"