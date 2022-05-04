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
dir=$(echo 0${programSlot} | tail -c 3)
dir=$(echo program${dir})
file="$1.dll"

# Print file and host to output
echo "Uploading $file ... to \"$sshHost\" in /$dir"

# Open SFTP connection to processor and put the file
sftp ${sshHost}:/${dir} << EOF
put $file
bye
EOF

echo "Uploaded, will now ssh to processor and run ..."

# Open SSH connection to processor and restart the program
ssh -t -t ${sshHost} << EOF
progres -P:${programSlot}
bye
EOF

echo "Disconnected. Complete"
exit 0

#Example VC4 script below

#host='vc4-host-or-ip'
#programId=1
#token='inserttokenhere'
#
#file="$1.cpz"
#iPadFile="$2CrestronAppProjectFile_Project.zip"
#
#echo "Project directory is $2"
#echo "Mobility project file is $iPadFile"
#echo "CPZ File is $1"

#curl -v --request PUT \
#  --url "http:/$host/VirtualControl/config/api/ProgramLibrary" \
#  --header "Authorization: $token" \
#  --form AppFile=@"${file}" \
#  --form MobilityFile=@"${iPadFile}" \
#  --form ProgramId=$programId \
#  --form StartNow=true
#  
#exit 0