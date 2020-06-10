extends Node2D

class_name Sounds

onready var main_sfx = $PrimarySfx
onready var second_sfx = $SecondSfx
onready var ambient_sfx = $Ambient

func play_primary(sound_item : String):
	main_sfx.stream = load(sound_item)
	main_sfx.play()

func play_second(sound_item : String):
	second_sfx.stream = load(sound_item)
	second_sfx.play()

func play_ambient(sound_item : String):
	ambient_sfx.stream = load(sound_item)
	ambient_sfx.play()
