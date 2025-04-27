/client/proc/give_comment(good_or_bad, key, admin, reason)
	var/json_file = file("data/player_saves/[copytext(key,1,2)]/[key]/pq_num.json")
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")
	var/list/json = json_decode(file2text(json_file))
	fdel(json_file)
	WRITE_FILE(json_file, json_encode(json))

	var/text
	if(good_or_bad >= 1)
		text += "Похвала от <b>[admin]</b> за: <i>[reason]</i> ([GLOB.rogue_round_id]) \n"
		text2file(text,"data/player_saves/[copytext(key,1,2)]/[key]/playerquality.txt")
		message_admins("<small>[admin] похвалил (без PQ) [key] с причиной: [reason]</small>")
	else
		text = "Недовольство от <b>[admin]</b> за: <i>[reason]</i> ([GLOB.rogue_round_id]) \n"
		text2file(text,"data/player_saves/[copytext(key,1,2)]/[key]/playerquality.txt")
		message_admins("<small>[admin] поругал (без PQ) [key] с причиной: [reason]</small>")

/client/proc/add_uncommend(key, giver)
	if(!giver || !key)
		return
	var/fakekey = src.ckey
	if(src.ckey in GLOB.anonymize)
		fakekey = get_fake_key(src.ckey)

	to_chat(src, span_danger("Укажите краткую причину этого изменения.<br>\
	Учитывайте, что игрок может не знать всего контекста произошедших с вами событий и может быть НЕ их виной.<br>\
	Критикуйте только если навредили игровой атмосфере или произошёл гриф без веской причины. Не спамьте критикой.<br>\
	Примеры - неуместный сленг, убийство бандитом при кооперации жертвы, пытки без видимой на то причины, не имеющее IC обоснования убийство, запирание до конца раунда без интересной игры, не подходящий сеттингу тёмного фэнтези отыгрыш.<br>\
	В конце концов, спросите себя — <b>\"Это игра такая жестокая или это игрок перегнул палку?\"</b>"))

	var/raisin = stripped_multiline_input(src, \
	"Во-первых, вы точно приходите в онлайн игру, чтобы копить обиду там, куда приходят отдыхать? Во-вторых, подробно опишите причину негативной рецензии на чужую игру. Без оскорблений.", "Он точно заслужил это?", "", null)
	if(!raisin)
		to_chat(src, span_boldwarning("Причина не указана."))
		return FALSE

	give_comment(-1, ckey(key), fakekey, raisin)
	return TRUE

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
