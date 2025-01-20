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
		message_admins("[admin] похвалил (без PQ) [key] с причиной: [reason]")
	else
		text = "Недовольство от <b>[admin]</b> за: <i>[reason]</i> ([GLOB.rogue_round_id]) \n"
		text2file(text,"data/player_saves/[copytext(key,1,2)]/[key]/playerquality.txt")
		message_admins("[admin] поругал (без PQ) [key] с причиной: [reason]")

/client/proc/add_uncommend(key, giver)
	if(!giver || !key)
		return
	var/curcomm = 0
	var/json_file = file("data/player_saves/[copytext(key,1,2)]/[key]/commends.json")
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")
	var/list/json = json_decode(file2text(json_file))
	if(json[giver])
		curcomm = json[giver]
	curcomm++
	json[giver] = curcomm
	fdel(json_file)
	WRITE_FILE(json_file, json_encode(json))

	var/fakekey = src.ckey
	if(src.ckey in GLOB.anonymize)
		fakekey = get_fake_key(src.ckey)

	to_chat(src, span_danger("Укажите краткую причину этого изменения. \
	Учитывайте, что игрок может не знать всего контекста произошедших с вами событий и может быть НЕ их виной. \
	Ставьте негативную оценку только если навредили игровой атмосфере или произошёл гриф без веской причины. \
	Примеры - неуместный сленг, убийство бандитом при кооперации жертвы, пытки без видимой на то причины, не имеющее IC обоснования убийство, запирание до конца раунда без интересной игры, не подходящее сеттингу тёмного фэнтези.<br>\
	В конце концов, спросите себя — <b>\"Это игра такая жестокая или это игрок перегнул палку?\"</b>"))

	var/raisin = stripped_input(src, \
	"Бро, перед тем, как ты это сделаешь, посмотри в чат.", "Он точно заслужил это?", "", null)
	if(!raisin)
		to_chat(src, span_boldwarning("Причина не указана."))
		return

	if(curcomm == 1)
		adjust_playerquality(-1, ckey(key), fakekey, raisin)
	else
		give_comment(-1, ckey(key), fakekey, raisin)
