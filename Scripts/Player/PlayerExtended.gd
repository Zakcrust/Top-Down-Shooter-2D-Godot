extends Player


func _on_Hitbox_body_entered(body):
	if body is Zombies:
		state = states.dead
		set_dead(true)
