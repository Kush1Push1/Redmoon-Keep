/datum/preferences
	var/negative_commented_someone = FALSE

/client/proc/can_uncommend(silent = FALSE)
	if(!prefs)
		return FALSE
	if(prefs.negative_commented_someone)
		if(!silent)
			if(usr?.client?.prefs?.be_russian)
				to_chat(src, span_danger("Вы уже поругали кого-то в этом раунде."))
			else
				to_chat(src, span_danger("You already uncommended someone this round."))
		return FALSE
	return TRUE
