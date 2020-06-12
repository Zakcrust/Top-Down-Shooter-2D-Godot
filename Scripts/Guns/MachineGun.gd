extends Guns

export (Texture) var mg_img = load("res://Assets/PNG/weapon_gun.png")
export (int) var mg_damage : int = 5
export (float) var mg_reload_speed = 0.1
export (bool) var is_full_auto = true

func _init().(mg_img, mg_damage, mg_reload_speed, is_full_auto):
	pass
