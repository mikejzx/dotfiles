#!/bin/bash

#
# This script syncs all of my e-mail except for my ProtonMail.
# This script is to be run at less of an interval than the PM account's script.
#

# Create lock to only allow one instance of mbsync.
if ! mkdir /tmp/mailsync.lock 2>/dev/null; then
	echo "Mailsync already running." >&2
	exit 1
fi

echo "Syncing all other mailboxes..."

# Just do a normal sync. These are all Gmail mailboxes so I don't really care that much.
mbsync --config="$XDG_CONFIG_HOME/mbsyncrc" school

# Re-index new mail.
echo "Indexing mail..."
echo "$($HOME/src/scripts/mutt/notmuch-hook.sh 2>&1)" | tail -n 2
echo "Mail indexed."

# Remove the lock.
rm -rf /tmp/mailsync.lock
