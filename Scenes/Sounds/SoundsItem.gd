extends Sounds

export (Dictionary) var sound_list

func play_primary_sfx(key : String):
	if sound_list.has(key):
		play_primary(sound_list[key])

func play_second_sfx(key : String):
	if sound_list.has(key):
		play_second(sound_list[key])

func play_ambient_sfx(key : String):
	if sound_list.has(key):
		play_ambient(sound_list[key])
