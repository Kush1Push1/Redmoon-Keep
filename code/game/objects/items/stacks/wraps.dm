

/*
 * Wrapping Paper
 */

/obj/item/stack/wrapping_paper
	name = "wrapping paper"
	desc = ""
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "wrap_paper"
	item_flags = NOBLUDGEON
	amount = 25
	max_amount = 25
	resistance_flags = FLAMMABLE

/obj/item/stack/wrapping_paper/use(used, transfer)
	var/turf/T = get_turf(src)
	. = ..()
	if(QDELETED(src) && !transfer)
		new /obj/item/c_tube(T)


/*
 * Package Wrap
 */

/obj/item/stack/packageWrap
	name = "package wrapper"
	singular_name = "wrapping sheet"
	desc = ""
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "deliveryPaper"
	item_flags = NOBLUDGEON
	amount = 25
	max_amount = 25
	resistance_flags = FLAMMABLE
	grind_results = list(/datum/reagent/cellulose = 5)

/obj/item/proc/can_be_package_wrapped() //can the item be wrapped with package wrapper into a delivery package
	return 1

/obj/item/storage/can_be_package_wrapped()
	return 0

/obj/item/storage/box/can_be_package_wrapped()
	return 1

/obj/item/smallDelivery/can_be_package_wrapped()
	return 0

/obj/item/stack/packageWrap/afterattack(obj/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(!istype(target))
		return
	if(target.anchored)
		return

	if(isitem(target))
		var/obj/item/I = target
		if(!I.can_be_package_wrapped())
			return
		if(user.is_holding(I))
			if(!user.dropItemToGround(I))
				return
		else if(!isturf(I.loc))
			return
		if(use(1))
			var/obj/item/smallDelivery/P = new /obj/item/smallDelivery(get_turf(I.loc))
			if(user.Adjacent(I))
				P.add_fingerprint(user)
				I.add_fingerprint(user)
				user.put_in_hands(P)
			I.forceMove(P)
			var/size = round(I.w_class)
			P.name = "[weightclass2text(size)] parcel"
			P.w_class = size
			size = min(size, 5)
			P.icon_state = "deliverypackage[size]"
	else
		to_chat(user, span_warning("The object you are trying to wrap is unsuitable for the sorting machinery!"))
		return

	user.visible_message(span_notice("[user] wraps [target]."))
	user.log_message("has used [name] on [key_name(target)]", LOG_ATTACK, color="blue")

/obj/item/stack/packageWrap/use(used, transfer = FALSE)
	var/turf/T = get_turf(src)
	. = ..()
	if(QDELETED(src) && !transfer)
		new /obj/item/c_tube(T)

/obj/item/c_tube
	name = "cardboard tube"
	desc = ""
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "c_tube"
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 1
	throw_range = 5