extends Area2D

class_name Bullet

export (int) var bullet_damage = 2
export (int) var bullet_speed = 1000

var hit_effect = preload("res://Scenes/HitEffect/HitEffect.tscn")

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
		add_hit_effect()
		queue_free()

func _on_Area2D_body_entered(body):
	if body is Zombies:
		add_hit_effect()
		body.damage(bullet_damage)
		GlobalSounds.play_global_primary("bullet_hit")
		queue_free()
	if body is TileMap:
		queue_free()

func add_hit_effect() -> void:
	var hit_instance = hit_effect.instance()
	hit_instance.position = global_position
	get_parent().add_child(hit_instance)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
