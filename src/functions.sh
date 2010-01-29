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

# Push the results to the server
sendResults(){
	# Uses wget which is nice and fast to send the results to the server
	# We are checking for a "200 OK" from the server headers (wget -S)
	# TODO its currently saving the downloaded file... which is not what we want
	# Added the -N option so that the same file gets overwritten at least
	if  ! wget -SN $SERVER$USER_NAME/$KEY/$RESULT 2>&1 | grep -q "200 OK"; then
		echo 'its a disaster'
	else
		echo 'SUCCESS'
		
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
	# Lets send the results
	sendResults
fi
