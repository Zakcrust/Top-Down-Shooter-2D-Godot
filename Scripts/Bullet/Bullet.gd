extends Area2D

export (int) var bullet_damage = 10
export (int) var bullet_speed = 1000

func set_damage(value : int) -> void:
	bullet_damage = value

func get_damage() -> int:
	return bullet_damage

func set_speed(value : Vector2) -> void:
	bullet_speed = value

func get_speed() -> Vector2:
	return bullet_speed

func _process(delta):
	position += transform.x * bullet_speed * delta

func _on_Area2D_area_entered(area):
	if area is Zombies:
		queue_free()


func _on_Area2D_body_entered(body):
	if body is Zombies:
		body.disable_collider()
		queue_free()
	if body is TileMap:
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
