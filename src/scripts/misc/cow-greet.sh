#
# cow-greet.sh
#
# Displays a cow with a random quote.
# This will only work if the file
# at ~/.cache/run-cowsay-login exists.
#
# Create this file at login to show cow
# at every prompt after logging in.
#

# Show a cow with a quote the first time we open terminal after login.
if [[ -f ~/.cache/run-cowsay-login ]]; then
	# Choose a cow
	RANGE=7
	number=$RANDOM
	let "number %= $RANGE"
	case $number in
		0)
			cow="tux"
			;;
		1)
			cow="koala"
			;;
		2)
			cow="moose"
			;;
		3)
			cow="vader"
			;;
		4)
			cow="cower"
			;;
		5)
			cow="hellokitty"
			;;
		6)
			cow="sheep"
			;;
	esac

	RANGE=2
	number=$RANDOM
	let "number %= $RANGE"
	case $number in
		0)
			command="/usr/bin/cowsay"
			;;
		1)
			command="/usr/bin/cowthink"
			;;
	esac

	# Run it.
	fortune | $command -f $cow | lolcat

	# Don't show until next login
	rm ~/.cache/run-cowsay-login
fi
