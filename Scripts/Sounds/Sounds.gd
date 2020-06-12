extends AudioStreamPlayer2D

class_name Sounds

onready var main_sfx = $PrimarySfx
onready var main_current_volume : float = main_sfx.volume_db
onready var second_sfx = $SecondSfx
onready var second_current_volume : float = second_sfx.volume_db
onready var ambient_sfx = $Ambient
onready var ambient_current_volume : float = ambient_sfx.volume_db

func _play_primary(sound_item : String) -> void:
	main_sfx.stream = load(sound_item)
	main_sfx.play()

func _play_second(sound_item : String) -> void:
	second_sfx.stream = load(sound_item)
	second_sfx.play()

func _play_ambient(sound_item : String) -> void:
	ambient_sfx.stream = load(sound_item)
	ambient_sfx.play()

func _set_primary_volume(value : float) -> void:
	main_sfx.volume_db = value

func _set_second_volume(value : float) -> void:
	second_sfx.volume_db = value

func _set_ambient_volume(value : float) -> void:
	ambient_sfx.volume_db = value
