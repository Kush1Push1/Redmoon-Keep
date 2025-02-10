
/mob/living
	var/STASTR = 10
	var/STAPER = 10
	var/STAINT = 10
	var/STACON = 10
	var/STAEND = 10
	var/STASPD = 10
	var/STALUC = 10
	//buffers, the 'true' amount of each stat
	var/BUFSTR = 0
	var/BUFPER = 0
	var/BUFINT = 0
	var/BUFCON = 0
	var/BUFEND = 0
	var/BUFSPE = 0
	var/BUFLUC = 0
	var/statbuf = FALSE
	var/list/statindex = list()
	var/datum/patron/patron = /datum/patron/godless

/mob/living/proc/init_faith()
	set_patron(/datum/patron/godless)

/mob/living/proc/set_patron(datum/patron/new_patron)
	if(!new_patron)
		return TRUE
	if(ispath(new_patron))
		new_patron = GLOB.patronlist[new_patron]
	if(!istype(new_patron))
		return TRUE
	if(istype(patron))
		patron.on_loss(src)
	patron = new_patron
	new_patron.on_gain(src)
	return TRUE

/mob/living/proc/roll_stats()
	STASTR = 10
	STAPER = 10
	STAINT = 10
	STACON = 10
	STAEND = 10
	STASPD = 10
	STALUC = 10
	for(var/S in MOBSTATS)
		var/how_much = pick(-1, 0, 1)
		change_stat(S, how_much)
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		if(H.dna.species)
			// Species stats
			for(var/S in H.dna.species.specstats)
				change_stat(S, H.dna.species.specstats[S])
			if(gender == FEMALE)
				// Female species stats
				for(var/S in H.dna.species.specstats_f)
					change_stat(S, H.dna.species.specstats_f[S])
			else
				// Male species stats
				for(var/S in H.dna.species.specstats_m)
					change_stat(S, H.dna.species.specstats_m[S])
		switch(H.age)
			if(AGE_MIDDLEAGED)
				change_stat("speed", -1)
				change_stat("endurance", 1)
			if(AGE_OLD)
				change_stat("strength", -1)
				change_stat("speed", -2)
				change_stat("perception", -1)
				change_stat("constitution", -2)
				change_stat("intelligence", 3)
				change_stat("fortune", 1)
		if(HAS_TRAIT(src, TRAIT_LEPROSY))
			change_stat("strength", -5)
			change_stat("speed", -5)
			change_stat("endurance", -2)
			change_stat("constitution", -2)
			change_stat("intelligence", -5)
			change_stat("fortune", -5)
		if(HAS_TRAIT(src, TRAIT_PUNISHMENT_CURSE))
			change_stat("strength", -3)
			change_stat("speed", -3)
			change_stat("endurance", -3)
			change_stat("constitution", -3)
			change_stat("intelligence", -3)
			change_stat("fortune", -3)
			H.voice_color = "c71d76"
			set_eye_color(H, "#c71d76", "#c71d76")
		if(isseelie(src))	//Check necessary to prevent seelie getting default stats when no other changes apply
			change_stat("strength", -9)

/mob/living/proc/change_stat(stat, amt, index)
	if(!stat)
		return
	if(amt == 0 && index)
		if(statindex[index])
			change_stat(statindex[index]["stat"], -1*statindex[index]["amt"])
			statindex[index] = null
			return
	if(!amt)
		return
	if(index)
		if(statindex[index])
			return //we cannot make a new index
		else
			statindex[index] = list("stat" = stat, "amt" = amt)
//			statindex[index]["stat"] = stat
//			statindex[index]["amt"] = amt
//	var/newamt = 0
	switch(stat)
		if("strength")
			if(isseelie(src))
				STASTR = 1
				return
			BUFSTR += amt
			STASTR = CLAMP(ROUNDSTART_STASTR + BUFSTR, 1, 20)

		if("perception")
			BUFPER += amt
			STAPER = CLAMP(ROUNDSTART_STAPER + BUFPER, 1, 20)
			see_override = initial(src.see_invisible) + (STAPER/2.78) // This may be a mistake.
			update_sight() //Needed.
			update_fov_angles()

		if("intelligence")
			BUFINT += amt
			STAINT = CLAMP(ROUNDSTART_STAINT + BUFINT, 1, 20)

		if("constitution")
			BUFCON += amt
			STACON = CLAMP(ROUNDSTART_STACON + BUFCON, 1, 20)

		if("endurance")
			BUFEND += amt
			STAEND = CLAMP(ROUNDSTART_STAEND + BUFEND, 1, 20)

		if("speed")
			BUFSPE += amt
			STASPD = CLAMP(ROUNDSTART_STASPD + BUFSPE, 1, 20)

		if("fortune")
			BUFLUC += amt
			STALUC = CLAMP(ROUNDSTART_STALUC + BUFLUC, 1, 20)

/proc/generic_stat_comparison(userstat as num, targetstat as num)
	var/difference = userstat - targetstat
	if(difference > 1 || difference < -1)
		return difference * 10
	else
		return 0

/mob/living/proc/badluck(multi = 3)
	if(STALUC < 10)
		return prob((10 - STALUC) * multi)

/mob/living/proc/goodluck(multi = 3)
	if(STALUC > 10)
		return prob((STALUC - 10) * multi)
