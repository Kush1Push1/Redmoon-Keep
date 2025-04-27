/datum/crafting_recipe/roguetown/larmorconvone
	name = "leather armor to bikini"
	result = /obj/item/clothing/suit/roguetown/armor/leather/bikini
	reqs = list(/obj/item/clothing/suit/roguetown/armor/leather = 1)

/datum/crafting_recipe/roguetown/larmorconvtwo
	name = "leather bikini to bra"
	result = /obj/item/clothing/suit/roguetown/armor/leather/bikini/bra
	reqs = list(/obj/item/clothing/suit/roguetown/armor/leather/bikini = 1)

/datum/crafting_recipe/roguetown/hidearmorconvone
	name = "hide armor to bikini"
	result = /obj/item/clothing/suit/roguetown/armor/leather/hide/bikini
	reqs = list(/obj/item/clothing/suit/roguetown/armor/leather/hide = 1)

/datum/crafting_recipe/roguetown/hidearmorconvtwo
	name = "hide bikini to bra"
	result = /obj/item/clothing/suit/roguetown/armor/leather/hide/bikini/bra
	reqs = list(/obj/item/clothing/suit/roguetown/armor/leather/hide/bikini = 1)

/datum/crafting_recipe/roguetown/studdedconvone
	name = "studded armor to bikini"
	result = list(/obj/item/clothing/suit/roguetown/armor/leather/studded/bikini)
	reqs = list(/obj/item/clothing/suit/roguetown/armor/leather/studded = 1)

/datum/crafting_recipe/roguetown/studdedconvtwo
	name = "studded bikini to bra"
	result = list(/obj/item/clothing/suit/roguetown/armor/leather/studded/bikini/bra)
	reqs = list(/obj/item/clothing/suit/roguetown/armor/leather/studded/bikini = 1)

/datum/crafting_recipe/roguetown/lharmorconvone
	name = "hardened leather armor to bikini"
	result = /obj/item/clothing/suit/roguetown/armor/leather/advanced/bikini
	reqs = list(/obj/item/clothing/suit/roguetown/armor/leather/advanced = 1)

/datum/crafting_recipe/roguetown/lharmorconvtwo
	name = "hardened leather bikini to bra"
	result = /obj/item/clothing/suit/roguetown/armor/leather/advanced/bikini/bra
	reqs = list(/obj/item/clothing/suit/roguetown/armor/leather/advanced/bikini = 1)

/datum/crafting_recipe/roguetown/lmarmorconvone
	name = "enhanced leather armor to bikini"
	result = /obj/item/clothing/suit/roguetown/armor/leather/masterwork/bikini
	reqs = list(/obj/item/clothing/suit/roguetown/armor/leather/masterwork = 1)

/datum/crafting_recipe/roguetown/lmarmorconvtwo
	name = "enhanced leather bikini to bra"
	result = /obj/item/clothing/suit/roguetown/armor/leather/masterwork/bikini/bra
	reqs = list(/obj/item/clothing/suit/roguetown/armor/leather/masterwork/bikini = 1)

/datum/crafting_recipe/roguetown/ichainkiniconvone
	name = "chainmail to bikini"
	result = list(/obj/item/clothing/suit/roguetown/armor/chainmail/iron/bikini)
	reqs = list(/obj/item/clothing/suit/roguetown/armor/chainmail/iron = 1)

/datum/crafting_recipe/roguetown/chainkiniconvtwo
	name = "chainmail bikini to bra"
	result = list(/obj/item/clothing/suit/roguetown/armor/chainmail/bikini/bra)
	reqs = list(/obj/item/clothing/suit/roguetown/armor/chainmail/bikini = 1)

/datum/crafting_recipe/roguetown/halfplateconvone
	name = "halfplate armor to bikini"
	result = list(/obj/item/clothing/suit/roguetown/armor/plate/bikini)
	reqs = list(/obj/item/clothing/suit/roguetown/armor/plate = 1)

/datum/crafting_recipe/roguetown/halfplateconvtwo
	name = "halfplate bikini to bra"
	result = list(/obj/item/clothing/suit/roguetown/armor/plate/bikini/bra)
	reqs = list(/obj/item/clothing/suit/roguetown/armor/plate/bikini = 1)

/datum/crafting_recipe/roguetown/halfplateconvone
	name = "fullplate armor to bikini"
	result = list(/obj/item/clothing/suit/roguetown/armor/plate/full/bikini)
	reqs = list(/obj/item/clothing/suit/roguetown/armor/plate/full = 1)

/datum/crafting_recipe/roguetown/halfplateconvtwo
	name = "fullplate bikini to bra"
	result = list(/obj/item/clothing/suit/roguetown/armor/plate/full/bikini/bra)
	reqs = list(/obj/item/clothing/suit/roguetown/armor/plate/full/bikini = 1)

/datum/crafting_recipe/roguetown/sewing/maiddress
	name = "maid dress (3 cloths, fiber; EXPERT)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/maiddress)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/maidhead
	name = "maid headdress (1 cloth, fiber; EXPERT)"
	result = list(/obj/item/clothing/head/roguetown/maidhead)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/maidapron
	name = "maid apron (2 cloth, fiber; EXPERT)"
	result = list(/obj/item/clothing/cloak/apron/waist/maid)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/pyro_arrow
	name = "Pyroclastic Arrow x1 (+1 Arrow) (+1 Fyritius)"
	reqs = list(
		/obj/item/ammo_casing/caseless/rogue/arrow = 2,
		/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius = 2,
	)
	result = /obj/item/ammo_casing/caseless/rogue/arrow/pyro
	skill_level = 3

/datum/crafting_recipe/roguetown/pyro_bolt
	name = "Pyroclastic Bolt x1 (+1 Bolt) (+1 Fyritius)"
	reqs = list(
		/obj/item/ammo_casing/caseless/rogue/bolt = 2,
		/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius = 2,
	)
	result = /obj/item/ammo_casing/caseless/rogue/bolt/pyro
	skill_level = 3
