/datum/job/roguetown/ruler/New()
	. = ..()
	if(usr?.client?.prefs?.be_russian)
		title = "Герцог"
		tutorial = "Вы возвелись на трон, пройдя через интриги и политическое восстание. Вы абсолютная власть в этих землях и центр каждого заговора. \
					Каждый мужчина, женщина и ребенок в этом городе завидует вашей власти и готов заменить вас за долю секунды: покажите им, где они ошибаются."