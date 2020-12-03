#!/usr/bin/env sh

# Check if we have internet.
ping -c 1 -w 2 1.1.1.1 > /dev/null
if [ $? -ne 0 ]; then
	echo "No interwebs for mail send."
	exit 0
fi

QUEUEDIR="$HOME/mail/outbox/cur/"
LOCKFILE="$QUEUEDIR/.lock"
MAXWAIT=120

OPTIONS=$*

# eat some options that would cause msmtp to return 0 without sendmail mail
case "$OPTIONS" in
	*--help*)
	echo "$0: send mails in $QUEUEDIR"
	echo "Options are passed to msmtp"
	exit 0
	;;
	*--version*)
	echo "$0: unknown version"
	exit 0
	;;
esac

# wait for a lock that another instance has set
WAIT=0
while [ -e "$LOCKFILE" ] && [ "$WAIT" -lt "$MAXWAIT" ]; do
	sleep 1
	WAIT="$((WAIT + 1))"
done
if [ -e "$LOCKFILE" ]; then
	echo "Cannot use $QUEUEDIR: waited $MAXWAIT seconds for"
	echo "lockfile $LOCKFILE to vanish, giving up."
	echo "If you are sure that no other instance of this script is"
	echo "running, then delete the lock file."
	exit 1
fi

# change into $QUEUEDIR
cd "$QUEUEDIR" || exit 1

# check for empty queuedir
if [ "$(echo ./*.msmtp)" = './*.msmtp' ]; then
	echo "No mails in $QUEUEDIR"
	exit 0
fi

# lock the $QUEUEDIR
touch "$LOCKFILE" || exit 1

sentcount=0

# process all mails
for MSMTPFILE in *.msmtp; do
	MAILFILE="$(tail -n 1 $MSMTPFILE)"
	echo "*** Sending $MAILFILE to $(head -n 1 $MSMTPFILE | sed -e 's/^.*-- \(.*$\)/\1/' $MSMTPFILE) ..."
	if [ ! -f "$MAILFILE" ]; then
		echo "No corresponding file $MAILFILE found"
		echo "FAILURE"
		continue
	fi
	msmtp $OPTIONS $(head -n 1 "$MSMTPFILE") < "$MAILFILE"
	if [ $? -eq 0 ]; then
		rm "$MAILFILE" "$MSMTPFILE"
		echo "$MAILFILE sent successfully"
		sentcount=$(($sentcount+1))
	else
		echo "FAILURE"
	fi
done

# Notify
ICOPATH=/usr/share/pixmaps/neomutt.svg
notify-send "[Mutt] Sent $sentcount mails from Outbox." -i "$ICOPATH"

# remove the lock
rm -f "$LOCKFILE"

# Index
$HOME/src/scripts/mutt/notmuch-hook.sh

exit 0
