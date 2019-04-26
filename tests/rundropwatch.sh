#!/bin/sh

abort_dropwatch() {
	sleep 5
	killall -SIGINT dropwatch
}

abort_dropwatch &
echo -e "set alertlimit 1\nstart\nstop\nexit" | ../src/dropwatch -l kas

if [ $? -ne 0 ]
then
	grep -q NET_DM ./rundropwatch.sh.log
	if [ $? -eq 0 ]
	then
		# This platform doesn't support NET_DM, skip this test
		exit 77
	fi
fi



