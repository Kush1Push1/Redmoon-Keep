GLOBAL_LIST_EMPTY(vurdalak_spawn_locations)

/*
 * ДАТУМ АНТАГОНИСТА
 */

/datum/antagonist/vurdalak
	name = ROLE_VURDALAK
	roundend_category = "Vurdalaks"
	antagpanel_category = "Vurdalak"
	job_rank = ROLE_VURDALAK
	confess_lines = list(
		"GHRAAA!",
		"AAAGH!",
		"SSSUN WILL MAKE ME CRY!!"
	)
	rogue_enabled = TRUE
	var/day_debuff = TRUE
	var/bog_bounded = TRUE
	var/list/unique_victims = list()
	var/last_sound = 0
	var/hide_strenght = 200

///datum/antagonist/vurdalak/lesser/roundend_report()
//	return

/datum/antagonist/vurdalak/examine_friendorfoe(datum/antagonist/examined_datum,mob/examiner,mob/examined)
	if(istype(examined_datum, /datum/antagonist/werewolf/lesser))
		return span_boldnotice("I see Dendor's threads... Must be lupine. Dangerous foe.")
	if(istype(examined_datum, /datum/antagonist/werewolf))
		return span_boldnotice("I see strong Dendor's threads... Have to be old lupine. Dangerous foe.")
	if(istype(examined_datum, /datum/antagonist/vampirelord/lesser))
		return span_boldwarning("A lesser Vampire spawn... Another, weaker deadite.")
	if(istype(examined_datum, /datum/antagonist/vampirelord))
		return span_boldwarning("An Ancient Vampire... A powerful ")
	if(istype(examined_datum, /datum/antagonist/vurdalak))
		return span_boldwarning("A cursed creature of Night... Just like me.")

/datum/antagonist/vurdalak/on_gain()
	owner.special_role = name
	move_to_spawn_location()

	var/mob/living/carbon/human/H = owner.current
	H.vurdalak_transform()

	greet()
	forge_vurdalak_objectives()
	return ..()

/datum/antagonist/vurdalak/proc/move_to_spawn_location()
	owner.current.forceMove(pick(GLOB.vurdalak_spawn_locations))

/datum/antagonist/vurdalak/on_life(mob/user)
	if(!user)
		return
	if(owner.current.stat == DEAD)
		return
	var/mob/living/carbon/human/vurdalak = owner.current
	if(vurdalak.advsetup)
		return
	if(world.time % 5)
		if(day_debuff)
			if(GLOB.tod != "night")
				if(isturf(vurdalak.loc))
					var/turf/T = vurdalak.loc
					if(T.can_see_sky())
						if(T.get_lumcount() > 0.05)
							vurdalak.apply_status_effect(/datum/status_effect/debuff/vurdalak_sunlight_exposed)

		if(vurdalak.m_intent != MOVE_INTENT_SNEAK)
			if(last_sound + 15 SECONDS <= world.time)
				for(var/mob/living/carbon/human/target in range(4, user) - vurdalak)
					if(target.stat)
						continue
					if(target.m_intent == MOVE_INTENT_SNEAK)
						continue

					var/sound_to_pick = pick('sound/vo/mobs/wwolf/pain (1).ogg', 'sound/vo/mobs/wwolf/pain (2).ogg', 'sound/vo/mobs/wwolf/pain (3).ogg')
					playsound(vurdalak.loc, sound_to_pick, 80, 1)
					last_sound = world.time
					break

			if(last_sound + 15 SECONDS <= world.time)
				for(var/mob/living/carbon/human/target in range(7, user) - vurdalak)
					if(target.stat)
						continue
					if(target.m_intent == MOVE_INTENT_SNEAK)
						continue

					playsound(vurdalak.loc, 'sound/vo/mobs/wwolf/sniff.ogg', 80, 1)
					last_sound = world.time
					break
	
	if(bog_bounded)
		if(vurdalak.y >= 194) // Супер-проклято. Нужны нормальные зоны для помещений в болоте, потому что они одни и те же, что и в деревне.
			vurdalak.apply_status_effect(/datum/status_effect/debuff/vurdalak_church_exposed)

	vurdalak.reagents.add_reagent(/datum/reagent/medicine/healthpot, 1)

	if(vurdalak.on_fire)
		vurdalak.freak_out()

	vurdalak.blood_volume = min(vurdalak.blood_volume + 1, BLOOD_VOLUME_NORMAL)

/datum/antagonist/vurdalak/on_removal()
	if(!silent && owner.current)
		to_chat(owner.current, span_danger("I am no longer a [name]!"))
	owner.special_role = null
	owner.current = null
	return ..()

/datum/antagonist/vurdalak/proc/add_objective(datum/objective/O)
	objectives += O

/datum/antagonist/vurdalak/proc/remove_objective(datum/objective/O)
	objectives -= O

/datum/antagonist/vurdalak/proc/forge_vurdalak_objectives()
	if(!(locate(/datum/objective/vurdalak) in objectives))
		var/datum/objective/vurdalak/vurdalak_objective = new
		vurdalak_objective.owner = owner
		add_objective(vurdalak_objective)
		return

/datum/antagonist/vurdalak/greet()
	to_chat(owner.current, span_biginfo("I had been cursed for ages ago..."))
	to_chat(owner.current, span_biginfo("Astrata, the unforgiving ascended witch, had been dull to my pleads, while dark-minded folks mutilated my body for the knowledges I have tried to spread."))
	to_chat(owner.current, span_biginfo("The mind of mine had been shaken, but not lost to time. I already cannot remember my name nor family, but can recognise what I have become."))
	to_chat(owner.current, span_biginfo("With each night, I feel less and less disgust to myself, doing what I need to survive another dae."))

	owner.current.playsound_local(get_turf(owner.current), 'modular_redmoon/sounds/music/intro_vurdalak.ogg', 80, FALSE, pressure_affected = FALSE)

	owner.announce_objectives()

	return ..()

/datum/antagonist/vurdalak/proc/handle_power_up()
	if(unique_victims.len <= 10)
		to_chat(owner.current, owner.current.client.prefs.be_russian ? span_cult("Моя шкура станет плотнее, когда я регенерирую.") : span_cult("My hide will be more resilent after I regenerate myself."))
		hide_strenght += 20
	switch(unique_victims.len)
		if(1)
			to_chat(owner.current, owner.current.client.prefs.be_russian ? span_cult("Я чувствую себя сильнее.") : span_cult("I feel myself more powerful."))
			owner.current.change_stat(STAT_STRENGTH, 1)
		if(2)
			to_chat(owner.current, owner.current.client.prefs.be_russian ? span_cult("Я чувствую себя крепче.") : span_cult("I feel myself more resilent."))
			owner.current.change_stat(STAT_CONSTITUTION, 1)
			owner.current.adjust_triumphs(1)
		if(3)
			to_chat(owner.current, owner.current.client.prefs.be_russian ? span_cult("Необычная сила распространяется в моих ногах. Я могу двигаться быстрее.") : span_cult("Unusual power spreads in leg. I can move a bit faster now."))
			owner.current.change_stat(STAT_SPEED, 1)
		if(4)
			to_chat(owner.current, owner.current.client.prefs.be_russian ? span_cult("Я чувствую себя сильнее.") : span_cult("I feel myself more powerful."))
			owner.current.change_stat(STAT_STRENGTH, 1)
			owner.current.adjust_triumphs(1)
		if(5)
			to_chat(owner.current, owner.current.client.prefs.be_russian ? span_cult("Я чувствую себя крепче.") : span_cult("I feel myself more resilent."))
			owner.current.change_stat(STAT_CONSTITUTION, 1)
		if(6)
			to_chat(owner.current, owner.current.client.prefs.be_russian ? span_cult("Необычная сила распространяется в моих ногах. Я могу двигаться быстрее!") : span_cult("Unusual power spreads in leg. I can move a bit faster now!"))
			owner.current.change_stat(STAT_SPEED, 1)
			owner.current.adjust_triumphs(1)
		if(7)
			to_chat(owner.current, owner.current.client.prefs.be_russian ? span_cult("Моя кровь... Моя кровь кипит! Жажда убивать становится сильнее... Я ощущаю, как думать становится сложнее.") : span_cult("My blood... My blood boils! The urge to kill is more than before... Do I lose myself?"))
			owner.current.change_stat(STAT_ENDURANCE, 1)
			owner.current.change_stat(STAT_INTELLIGENCE, -1)
		if(8)
			to_chat(owner.current, owner.current.client.prefs.be_russian ? span_cult("Я ЧУВСТВУЮ СЕБЯ ВЫНОСЛИВЕЕ, ЧЕМ КОГДА ЛИБО! Я МОГУ УБИВАТЬ БОЛЬШЕ! ЦЕРКОВЬ УМОЕТСЯ В КРОВИ!") : span_cult("I FEEL MYSELF LESS FATIGUE THAN EVER BEFORE! I CAN KILL MORE! THE CHURCH WILL BATH IN BLOOD!"))
			owner.current.change_stat(STAT_ENDURANCE, 1)
			owner.current.change_stat(STAT_INTELLIGENCE, -1)
			owner.current.adjust_triumphs(1)
		if(9)
			to_chat(owner.current, owner.current.client.prefs.be_russian ? span_cult("Я ЧУВСТВУЮ... СОЛНЦЕ... ОНА НЕ ИМЕЕТ БОЛЕЕ ВЛАСТИ НАДО МНОЙ...") : span_cult("I FEEL... THE SUN... SHE HAS NO POWER OVER ME ANYMORE..."))
			owner.current.change_stat(STAT_INTELLIGENCE, -2)
			day_debuff = FALSE
		if(10)
			to_chat(owner.current, owner.current.client.prefs.be_russian ? span_cultbigbold("СИЛА ЦЕРКВИ БОЛЬШЕ НЕ СМОЖЕТ СДЕРЖАТЬ МЕНЯ! ЦЕРКОВЬ... НЕ СМОЖЕТ... СДЕРЖИВАТЬ МЕНЯ! КРОВЬ! СМЕРТЬ! Я САМА СМЕРТЬ!!!") : span_cultbigbold("THEIR LIFEFORCE DID LET ME TO PASS THE TERROR BOG! THE CHURCH... NO LONGER... HOLDS ME OFF... BLOOD! DEATH! AM THE DEATH ITSELF!!!"))
			owner.current.change_stat(STAT_INTELLIGENCE, -4)
			bog_bounded = FALSE

/*
 * ЗАДАЧИ
 */

/datum/objective/vurdalak
	name = "drink_blood"
	explanation_text = "With each and every dae, my lifeforce betrays me. I have to drink blood or feast on 10 victims, to sustain myself for a bit more."
	triumph_count = 5

/datum/objective/vurdalak/check_completion()
	var/datum/antagonist/vurdalak/vurdalak_datum = owner.has_antag_datum(/datum/antagonist/vurdalak)
	if(vurdalak_datum)
		if(vurdalak_datum.unique_victims.len >= 10)
			return TRUE

/*
 * СОСТОЯНИЯ
 */

/datum/status_effect/debuff/vurdalak_sunlight_exposed
	id = "hungryt2"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/hungryt2
	effectedstats = list("strength" = -5, "constitution" = -5, "speed" = -5)
	duration = 10 SECONDS

/datum/status_effect/debuff/vurdalak_church_exposed
	id = "hungryt3"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/hungryt2
	effectedstats = list("strength" = -8, "constitution" = -8, "speed" = -8) // Братан НЕ ДОЛЖЕН суваться в деревню
	duration = 10 SECONDS

/atom/movable/screen/alert/status_effect/debuff/vurdalak_sunlight_exposed
	name = "SUNLIGHT!"
	desc = "<span class='warning'>I feel myself sick of it!</span>\n"
	icon_state = "stressb"

/atom/movable/screen/alert/status_effect/debuff/vurdalak_church_exposed
	name = "Church!"
	desc = "<span class='warning'>Their church weakens me... I need to get back to the bog.</span>\n"
	icon_state = "stressvb"
