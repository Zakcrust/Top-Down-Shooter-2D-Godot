extends Node2D

var bullet : PackedScene = preload("res://Scenes/Bullet/Bullet.tscn")

func generate_bullet(damage : int, bullet_pos : Vector2, bullet_direction):
	var new_bullet = bullet.instance()
	add_child(new_bullet)
	new_bullet.position = bullet_pos
	new_bullet.rotate(bullet_direction)
	new_bullet.set_damage(damage)
	print(get_child_count())

func _on_Player_shoot(damage, bullet_position, bullet_direction):
	generate_bullet(damage, bullet_position, bullet_direction)
