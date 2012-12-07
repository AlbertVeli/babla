# Eggdrop script for calling translation scripts.
#
# when bot is in channel and someone types:
#
# !babla word
#
# svensk-engelsk.sh word is run and the reslults
# are printed in the irc channel.
#
# !tyda word
#
# similarly calls: tyda.sh word
#
###

bind pub - !babla do_babla
bind pub - !tyda do_tyda

proc run_trans_script { script nick chan args } {

    # XXX: Change this to your path!
    set path "/home/albert/source/babla"

    set script "$path/$script"

    # Try to comment out the following line if you dont
    # get results for words containing non-ascii chars.
    set args [encoding convertto utf-8 $args]

    if {[catch { exec $script $args } results] } {
        putserv "PRIVMSG $chan :$nick: error fetching translation for '$args'"
    } else {
        if { [strlen $results] > 0 } {
            set lines [split $results "\n"]
	    set first 1
            foreach line $lines {
		if { $first > 0 } {
		    putserv "PRIVMSG $chan :$nick: $line"
		    set first 0
		} else {
		    putserv "PRIVMSG $chan :$line"
		}
            }
        } else {
            putserv "PRIVMSG $chan :$nick: nothing found."
        }
    }

    return 0
}

proc do_babla { nick host hand chan args } {

    set script "svensk-engelsk.sh"

    set args [join $args]
    if { [strlen $args] <= 0 } {
        putserv "PRIVMSG $chan :$nick: usage - !babla <word>"
        return 1
    }

    return [run_trans_script $script $nick $chan $args]
}

proc do_tyda { nick host hand chan args } {

    set script "tyda.sh"

    set args [join $args]
    if { [strlen $args] <= 0 } {
        putserv "PRIVMSG $chan :$nick: usage - !tyda <word>"
        return 1
    }

    return [run_trans_script $script $nick $chan $args]
}
