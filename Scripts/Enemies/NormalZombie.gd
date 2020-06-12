extends Zombies

export (int) var zombie_speed = 50
export (int) var zombie_health = 50
export (int) var zombie_dmg_res = 0

func _init().(zombie_speed):
	set_health(zombie_health)
	set_damage_resistance(zombie_dmg_res)
