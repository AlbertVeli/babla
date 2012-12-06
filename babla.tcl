# Eggdrop script.
# Calls svensk-engelsk.sh when eggdrop bot
# is in channel and someone types:
# !babla word

bind pub - !babla do_babla

proc do_babla { nick host hand chan args } {
    set args [join $args]

    # XXX: Change this to your path!
    set path "/home/albert/source/babla"
    set script "$path/svensk-engelsk.sh"

    if { [strlen $args] <= 0 } {
        putserv "PRIVMSG $chan :$nick: usage - !babla <word>"
	return 1
    }

    # Try to comment out the following line if you
    # dont get any results for words with non-ascii chars.
    set args [encoding convertto utf-8 $args]

    if {[catch { exec $script $args } hits] } {
	putserv "PRIVMSG $chan :$nick: error fetching translation of $args."
    } else {
	if { [strlen $hits] > 0 } {
	    set data [split $hits "\n"]
	    foreach line $data {
		putserv "PRIVMSG $chan :$nick: $line"
	    }
	} else {
	    putserv "PRIVMSG $chan :$nick: nothing found."
	}
    }

    return 0
}
