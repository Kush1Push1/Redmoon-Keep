/obj/effect/proc_holder/spell
	var/fears_mount = FALSE // активация спелла пугает маунта

/obj/effect/proc_holder/spell/invoked/projectile
	fears_mount = TRUE

/obj/effect/proc_holder/spell/proc/mount_fear_check(mob/living/user)
	return FALSE

/obj/effect/proc_holder/spell/invoked/projectile/mount_fear_check(mob/living/user)
	if(!user.buckled)
		return FALSE
	if(isliving(user.buckled))
		var/mob/living/buckle_mob = user.buckled
		if(buckle_mob.mind)
			return FALSE // игрок-маунт не знает страха
		var/datum/component/riding/riding_component = buckle_mob.GetComponent(/datum/component/riding)
		if(riding_component.violently_drop_rider(src, user))
			user.visible_message(span_warning("[user] feared [user.gender == MALE ? "his" : "her"] mount!"), span_warning("My mount was feared by my powers! OUCH!"))
		return TRUE

/datum/component/riding/proc/violently_drop_rider(datum/source, mob/living/user, forced = FALSE)
	if(!ishostile(parent))
		return FALSE
	var/mob/living/simple_animal/hostile/buckle_mob = parent

	buckle_mob.get_sound("pain")
	AddElement(/datum/element/flee_from_target, 10 SECONDS)
	force_dismount(user)

	user.set_resting(TRUE, TRUE)
	var/obj/item/bodypart/damaged_during_falling = user.get_bodypart(pick(BODY_ZONE_PRECISE_GROIN, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
	if(user.badluck(5))
		to_chat(user, span_warningbig("UNLUCKY FALLING! OH [uppertext(user.patron.name)]!!"))
		if(damaged_during_falling == BODY_ZONE_PRECISE_GROIN)
			damaged_during_falling.add_wound(/datum/wound/fracture/groin)
		else
			damaged_during_falling.add_wound(/datum/wound/fracture)
	user.apply_damage(50, BRUTE, damaged_during_falling)
	user.emote("scream")
	return TRUE

/**
 * Attached to a mob with an AI controller, simply sets a flag on whether or not to run away based on current health values.
 */
/datum/element/flee_from_target
	/// От кого убегаем
	var/target
	/// Как долго
	var/how_long = 0

/datum/element/flee_from_target/Attach(datum/target, atom/threat, how_long_fleeing = 10 SECONDS)
	. = ..()
	if(!isliving(target))
		return ELEMENT_INCOMPATIBLE
	var/mob/living/living_target = target
	if(!living_target.ai_controller)
		return ELEMENT_INCOMPATIBLE
	src.target = target
	src.how_long = how_long_fleeing

/datum/element/flee_from_target/Detach(datum/source)
	target = null
	. = ..()

/// When the mob's health changes, check what the blackboard state should be
/datum/element/flee_from_target/New(mob/living/source)
	if(!source.ai_controller)
		return

	source.ai_controller.CancelActions()
	source.ai_controller.set_blackboard_key(BB_BASIC_MOB_FLEEING, TRUE)

	addtimer(CALLBACK(src, PROC_REF(cancel_flee), source), how_long, flags = TIMER_UNIQUE)

/datum/element/flee_from_target/proc/cancel_flee(mob/living/source)
	source?.ai_controller?.set_blackboard_key(BB_BASIC_MOB_FLEEING, FALSE)
	source.ai_controller.CancelActions()
	qdel()
