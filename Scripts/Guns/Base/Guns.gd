extends Node

class_name Guns

var image : Texture
var damage : int
var reload_speed : float
var auto : bool

func _init(default_image = Texture.new(), default_damage = 0, default_reload_speed = 0, default_auto = false):
	image = default_image
	damage = default_damage
	reload_speed = default_reload_speed
	auto = default_auto
	
func set_image(value : Texture) -> void:
	image = value

func get_image() -> Texture:
	return image

func set_damage(value : int) -> void:
	damage = value

func get_damage() -> int:
	return damage

func set_reload_speed(value : float) -> void:
	reload_speed = value

func get_reload_speed() -> float:
	return reload_speed

func set_auto(value : bool) -> void:
	auto = value

func get_auto() -> bool:
	return auto
