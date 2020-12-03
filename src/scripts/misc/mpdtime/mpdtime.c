/*
 * mpdtime.c
 *
 * Gets the time in seconds of the song MPD is currently playing.
 *
 * From a user from Reddit, who has deleted their account. Cheers dude
 * https://www.reddit.com/r/linux/comments/2399hw/mpdmpc_any_way_to_get_current_time_of_song_in/
 *
 * Compilation:
 * gcc mpdtime.c -o mpdtime -lmpdclient
 */

#include <mpd/status.h>
#include <mpd/connection.h>
#include <stdio.h>

int main(void)
{
	unsigned time = 0;
	struct mpd_connection *conn;
	struct mpd_status *status;
	enum mpd_state state;

	conn = mpd_connection_new(NULL, 0, 0);
	status = mpd_run_status(conn);
	if (!status) return 0;
	time = mpd_status_get_elapsed_time(status);
	state = mpd_status_get_state(status);
	mpd_status_free(status);
	mpd_connection_free(conn);

	printf("%u\n", time);

	return 0;
}
