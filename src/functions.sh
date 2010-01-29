#!/bin/bash

## VARIABLES ##

# Test mode (1 = test mode, results are echoed. 0 = live mode, results are posted to the server)
TEST=0

# The user name for this user
USER_NAME="Bob"

# This is the unique key that associates a user account with a server
# Note: Each server should have its own key
KEY="KjJ7F09hfu8fyF8"

# The server address
# This must start with 'http(s)://' and end with '/'
SERVER="http://eventarc.feurio/sandbox/ae/add/"

# This will be used to store each of the results
RESULT=""

# Used to seperate the results key from its value
# ie. $resultKey$SEPARATOR$resultValue
SEPARATOR="_"

# Added to the end of each added result
END="/"

## FUNCTIONS ##
getLoad(){
	# We only care about the 5 minute load average
	#load="$(uptime | awk -F 'load average:' '{ print $2 }' | cut -d, -f2)"
	resultKey="load"
	resultValue="$(cat /proc/loadavg | awk '{print $2}')"
	
	RESULT+=$resultKey$SEPARATOR$resultValue$END
}

apache2Count(){
	# Number of apache2 processes
	resultKey="apache2count"
	resultValue="$(pgrep -c 'apache2')"
	
	RESULT+=$resultKey$SEPARATOR$resultValue$END
}
 
swap(){
	# Value of swap usage as defined by free -m
	resultKey="swap"
	resultValue="$(free -m | awk '/Swap:/ {print $3}')"
	
	RESULT+=$resultKey$SEPARATOR$resultValue$END
}

postResults(){
	wget -S --output-file=/tmp/wgetOutput.txt $SERVER$USER_NAME/$KEY/$RESULT
	count="$(grep -c '200 OK' /tmp/wgetOutput.txt)"
	
	if [ $count -eq 0 ]; then
		echo 'Failed to post results'
	elif [ $count -eq 1 ]; then
		echo 'Success'
	else
		echo 'Failed to post results... something strange happened'
	fi
	
}

# List of functions to run
getLoad
apache2Count
swap

# Do the business
# Check to see if we are in test mode (just echo the RESULT)
if [ $TEST -eq 1 ]; then
	echo "RESULT: $RESULT"
else
	# Lets post the results
	postResults
fi
