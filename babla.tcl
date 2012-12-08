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
# and !lexin word calls folkets.sh
#
###

bind pub - !babla do_babla
bind pub - !tyda do_tyda
bind pub - !lexin do_folkets_sven
bind pub - !folkets do_folkets_sven
bind pub - !folken do_folkets_ensv
bind pub - !folksyn do_folkets_syn
bind pub - !synonymer do_synonymer
bind pub - !syn do_synonymer

proc run_trans_script { script nick chan args } {
    global lastbind

    # XXX: Change this to your path!
    set scriptdir "/home/albert/source/babla"

    set scriptpath "$scriptdir/$script"

    set args [join [join $args]]
    if { [strlen $args] <= 0 } {
	# $::lastbind is global and automatically set by eggdrop
        putserv "PRIVMSG $chan :$nick: usage - $::lastbind <word>"
        return 0
    }

    # Try to comment out the following line if you dont
    # get results for words containing non-ascii chars.
    set args [encoding convertto utf-8 $args]

    if {[catch { exec $scriptpath $args } results] } {
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
    return [run_trans_script $script $nick $chan $args]
}

proc do_tyda { nick host hand chan args } {
    set script "tyda.sh"
    return [run_trans_script $script $nick $chan $args]
}

proc do_folkets_sven { nick host hand chan args } {
    set script "folkets_lexikon_sven.py"
    return [run_trans_script $script $nick $chan $args]
}

proc do_folkets_ensv { nick host hand chan args } {
    set script "folkets_lexikon_ensv.py"
    return [run_trans_script $script $nick $chan $args]
}

proc do_folkets_syn { nick host hand chan args } {
    set script "folkets_syn.py"
    return [run_trans_script $script $nick $chan $args]
}

proc do_synonymer { nick host hand chan args } {
    set script "synonymer.sh"
    return [run_trans_script $script $nick $chan $args]
}
