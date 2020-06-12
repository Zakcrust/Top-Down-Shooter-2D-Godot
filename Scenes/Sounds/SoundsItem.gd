extends Sounds

export (Dictionary) var sound_list
export (float, -80, 24, 1) var primary_db
export (float, -80, 24, 1) var secondary_db
export (float, -80, 24, 1) var ambient_db


func _ready():
	_set_primary_volume(primary_db)
	_set_second_volume(secondary_db)
	_set_ambient_volume(ambient_db)


func play_primary_sfx(key : String):
	if sound_list.has(key):
		_play_primary(sound_list[key])


func play_second_sfx(key : String):
	if sound_list.has(key):
		_play_second(sound_list[key])


func play_ambient_sfx(key : String):
	if sound_list.has(key):
		_play_ambient(sound_list[key])
	
