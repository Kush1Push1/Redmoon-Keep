/datum/reagent/medicine/purify/on_mob_life(mob/living/carbon/human/M)
	. = ..()
	if(M.mind.has_antag_datum(/datum/antagonist/werewolf))
		M.mind.remove_antag_datum(/datum/antagonist/werewolf)
		to_chat(M, "You feel the werewolf curse burning intensely.")
	if(M.mind.has_antag_datum(/datum/antagonist/werewolf/lesser))
		M.mind.remove_antag_datum(/datum/antagonist/werewolf/lesser)
		to_chat(M, "You feel the werewolf curse burning intensely.")
