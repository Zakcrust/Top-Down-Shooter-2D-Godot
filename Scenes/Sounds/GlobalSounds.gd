extends Node2D

export (Dictionary) var global_sound_list

func _ready():
	$Sounds.sound_list = global_sound_list

func play_global_primary(key : String) -> void:
	$Sounds.play_primary_sfx(key)


func play_global_second(key : String) -> void:
	$Sounds.play_second_sfx(key)


func play_global_ambient(key : String) -> void:
	$Sounds.play_ambient_sfx(key)
