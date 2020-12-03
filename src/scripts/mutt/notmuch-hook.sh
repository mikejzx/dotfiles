#!/bin/sh

#
# notmuch-hook.sh
#
# Retags all mail
#

# Look for new messages.
echo "$(notmuch new 2>&1)" | tail -n 2

# Retag all "new" messages "inbox" and "unread"
notmuch tag +unread -new -- tag:new
notmuch tag +inbox folder:'pm/INBOX'
notmuch tag +inbox folder:'gmail/Inbox'
notmuch tag +inbox folder:'gmail0/Inbox'
notmuch tag +inbox folder:'school/Inbox'

# Remove from unread if it's in our sent mail.
notmuch tag -unread folder:'pm/Sent'
notmuch tag -unread folder:'pm/gmail/[Gmail]/Sent Mail'
notmuch tag -unread folder:'pm/gmail0/[Gmail]/Sent Mail'
notmuch tag -unread folder:'pm/school/[Gmail]/Sent Mail'

# Tag outbox messages we remove "new" and "unread tags too."
notmuch tag --remove-all +outbox folder:'outbox'
