#!/usr/bin/env sh

QUEUEDIR=$HOME/mail/outbox/cur/

# Set secure permissions on created directories and files
umask 077

# Change to queue directory (create it if necessary)
if [ ! -d "$QUEUEDIR" ]; then
	mkdir -p "$QUEUEDIR" || exit 1
fi
cd "$QUEUEDIR" || exit 1

# Create new unique filenames of the form
# MAILFILE:  ccyy-mm-dd-hh.mm.ss[-x]
# MSMTPFILE: ccyy-mm-dd-hh.mm.ss[-x].msmtp
# where x is a consecutive number only appended if you send more than one
# mail per second.
#BASE="$(date +%Y-%m-%d-%H.%M.%S)"
# New unique name. Based off of Maildir format.
BASE="$(date +%s).$(ps -p $$ | tail -n 1 | awk '{print $1;}').$(hostname),U=$(ls -1 | wc -l),:2,S"
if [ -f "$BASE" ] || [ -f "$BASE.msmtp" ]; then
	TMP="$BASE"
	i=1
	while [ -f "$TMP-$i.mail" ] || [ -f "$TMP-$i.msmtp" ]; do
		i=$((i + 1))
	done
	BASE="$BASE-$i"
fi
MAILFILE="$BASE"
MSMTPFILE="$BASE.msmtp"

# Write command line to $MSMTPFILE
echo "$@" > "$MSMTPFILE" || exit 1

# Write the mail file name.
echo "$MAILFILE" >> "$MSMTPFILE" || exit 1

# Write the mail to $MAILFILE
cat > "$MAILFILE" || exit 1

# Try run the queue.
$HOME/src/scripts/mutt/outbox/msmtp-runqueue.sh > /dev/null &

exit 0
