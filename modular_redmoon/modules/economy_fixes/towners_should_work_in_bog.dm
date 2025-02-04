// Охота в окрестностях города - бесполезная затея
/obj/item/bait/attack_self(mob/user)
	if(!istype(get_area(src), /area/rogue/outdoors/bog))
		to_chat(user, span_warning(user.client.prefs.be_russian ? "В окрестностях Рокхилла не осталось живности... В болотах шансов приманить кого-нибудь больше." : "There will not be enought wildlife here. I should place [src] in the bog..."))
		return FALSE
	. = ..()

// С деревьев у рокхилла доходность леса очень сильно падает
/obj/structure/flora/newtree
	var/tree_not_in_bog = FALSE // оповещение для дровосека, чтобы шёл рубить болото

/obj/structure/flora/newtree/Initialize()
	if(!istype(get_area(loc), /area/rogue/outdoors/bog))
		static_debris = list(/obj/item/grown/log/tree/small = 1)
		tree_not_in_bog = TRUE
		if(istype(get_turf(src), /turf/open/transparent/openspace))
			static_debris = list() // отсутствие древесины в целом, фармите болото, дровосеки
			tree_not_in_bog = FALSE // некому показывать
	. = ..()

// Добыча в шахтах рокхилла - не особо прибыльное дело, но кузнец явно скажет спасибо. Золото и другие ценные руды можно добыть за городом
/turf/closed/mineral/random/rogue/Initialize()
	check_for_bog_area()
	. = ..()

/turf/closed/mineral/random/proc/check_for_bog_area()
	return TRUE

/turf/closed/mineral/random/rogue/med/check_for_bog_area()
	if(!istype(get_area(src), /area/rogue/under/cavewet/bogcaves))
		mineralSpawnChanceList = list(/turf/closed/mineral/rogue/salt = 5,/turf/closed/mineral/rogue/iron = 15,/turf/closed/mineral/rogue/copper = 15,/turf/closed/mineral/rogue/coal = 25)

/turf/closed/mineral/random/rogue/high/check_for_bog_area()
	if(!istype(get_area(src), /area/rogue/under/cavewet/bogcaves))
		mineralSpawnChanceList = list(/turf/closed/mineral/rogue/salt = 5,/turf/closed/mineral/rogue/iron = 15,/turf/closed/mineral/rogue/copper = 15,/turf/closed/mineral/rogue/coal = 25)

// Рыбаку ловить у города для удачного подъёма смысла мало
/obj/item/proc/check_for_bait_location()
	return FALSE

/obj/item/natural/worms/check_for_bait_location()
	if(!istype(get_area(src), /area/rogue/outdoors/bog) || !istype(get_area(src), /area/rogue/under/cavewet/bogcaves))
		fishloot = list(\
			/obj/item/trash/applecore = 50,
			/obj/item/trash/pearcore = 25, //Pears, in Rockhill? Perish the thought.
			/obj/item/natural/fibers = 15, //It's pretty hard to hook a fiber.
			/obj/item/grown/log/tree/stick = 2, //Single stick
			/obj/item/reagent_containers/food/snacks/fish/carp = 214,
			/obj/item/reagent_containers/food/snacks/fish/eel = 214,
			/obj/item/reagent_containers/food/snacks/fish/angler = 214,
			/obj/item/reagent_containers/food/snacks/fish/shrimp = 180, //Shrimp man gone. Life bad.
			/obj/item/reagent_containers/food/snacks/fish/clownfish = 214,
			/obj/item/natural/bundle/stick = 15, //Bundle of sticks
			/obj/item/natural/stone = 15, //Hard to catch stones!
			/obj/item/clothing/head/roguetown/helmet/tricorn = 25,
			/obj/item/clothing/head/roguetown/helmet/bandana = 25,
			/obj/item/clothing/head/roguetown/roguehood = 25,
			/obj/item/clothing/under/roguetown/loincloth/brown = 25,
			/obj/item/clothing/shoes/roguetown/sandals = 25,
			/obj/item/clothing/shoes/roguetown/simpleshoes = 25,
			/obj/item/clothing/gloves/roguetown/fingerless = 25,
			/obj/item/clothing/gloves/roguetown/leather = 25,
			/obj/item/clothing/shoes/roguetown/armor/leather = 25,
			/obj/item/reagent_containers/syringe = 1, //These are terrifyingly powerful.
			/obj/item/reagent_containers/glass/cup/wooden = 27,
			/obj/item/ammo_casing/caseless/rogue/arrow = 45,
			/obj/item/roguecoin/copper = 45,
			/obj/item/leash = 15,
			/obj/item/customlock = 35,
			/obj/item/shard = 1, //Bait is smaller
			/obj/item/natural/feather = 15,
			/obj/item/natural/cloth = 15,
			/obj/item/kitchen/spoon = 1,)
		return TRUE
	return FALSE

/obj/item/natural/worms/grubs/check_for_bait_location()
	if(!istype(get_area(src), /area/rogue/outdoors/bog) || !istype(get_area(src), /area/rogue/under/cavewet/bogcaves))
		fishloot = list(\
			/obj/item/trash/applecore = 625,
			/obj/item/trash/pearcore = 625,
			/obj/item/natural/fibers = 625,
			/obj/item/grown/log/tree/stick = 625,
			/obj/item/reagent_containers/food/snacks/fish/carp = 214,
			/obj/item/reagent_containers/food/snacks/fish/eel = 214,
			/obj/item/reagent_containers/food/snacks/fish/angler = 214,
			/obj/item/reagent_containers/food/snacks/fish/shrimp = 214,
			/obj/item/reagent_containers/food/snacks/fish/clownfish = 214,
			/obj/item/natural/bundle/stick = 214,
			/obj/item/natural/stone = 214,
			/obj/item/clothing/head/roguetown/helmet/tricorn = 45,
			/obj/item/clothing/head/roguetown/helmet/bandana = 45,
			/obj/item/clothing/head/roguetown/roguehood = 45,
			/obj/item/clothing/under/roguetown/loincloth/brown = 45,
			/obj/item/clothing/shoes/roguetown/sandals = 45,
			/obj/item/clothing/shoes/roguetown/simpleshoes = 45,
			/obj/item/clothing/gloves/roguetown/fingerless = 45,
			/obj/item/clothing/gloves/roguetown/leather = 45,
			/obj/item/clothing/shoes/roguetown/armor/leather = 45,
			/obj/item/reagent_containers/syringe = 1,
			/obj/item/reagent_containers/glass/cup/wooden = 45,
			/obj/projectile/bullet/reusable/bolt = 45,
			/obj/item/ammo_casing/caseless/rogue/arrow = 45,
			/obj/item/roguecoin/copper = 45,
			/obj/item/leash = 45,
			/obj/item/customlock = 45,
			/obj/item/shard = 45,
			/obj/item/natural/feather = 45,
			/obj/item/natural/cloth = 45,
			/obj/item/kitchen/spoon = 45,)
		return TRUE
	return FALSE
