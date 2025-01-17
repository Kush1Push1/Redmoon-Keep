// Check comments with "memory_for_family_members" for all related code.

/datum/preferences
	var/spouse_ckey = null
	var/allow_alt_genitals_for_spouse = FALSE

/datum/preferences/_load_appearence(S)
	. = ..()
	S["spouse_ckey"]		>> spouse_ckey

/datum/controller/subsystem/ticker
	var/families = 0
