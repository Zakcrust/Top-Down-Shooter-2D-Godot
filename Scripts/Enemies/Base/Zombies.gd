extends KinematicBody2D

class_name Zombies

var SPEED : int = 50

var state = states.idle
var player : KinematicBody2D


var paths : PoolVector2Array

enum states {
	idle, action, dead
}

func _ready():
	set_process(false)

func set_speed(value : int) -> void:
	SPEED = value

func get_speed() -> int:
	return SPEED

func set_paths(value : PoolVector2Array) -> void:
	paths = value
	paths.remove(0)
	set_process(true)

func get_paths() -> PoolVector2Array:
	return paths

func set_player(value : KinematicBody2D) -> void:
	player = value
	
func get_player() -> KinematicBody2D:
	return player

func _process(delta):
	match state:
		states.idle:
			pass
		states.action:
			action(delta)
		states.dead:
			pass


func action(delta):
	var move_distance = SPEED * delta
	look_at(player.position)
	move_along_path(move_distance)
	
func move_along_path(distance : float) -> void:
	var last_point : = position
	for index in range(paths.size()):
		var distance_to_next = last_point.distance_to(paths[0])
		if distance <= distance_to_next and distance >= 0.0:
			position = last_point.linear_interpolate(paths[0], distance / distance_to_next)
			break
		elif paths.size() == 1 and distance >= distance_to_next:
			position = paths[0]
			set_process(false)
			break

		distance -= distance_to_next
		last_point = paths[0]
		paths.remove(0)


func _on_PathTimer_timeout():
	if player.get_dead():
		$PathTimer.stop()
	else:
		update_path()


func update_path() -> void:
	var path = get_parent().get_simple_path(global_position, player.global_position)
#	var path = $Navigation2D.get_simple_path(global_position, player.global_position)
	print(path)
	if path != null:
		set_paths(path)


func _on_DetectRadius_body_entered(body):
	if body is Player and not state == states.dead:
		print("player detected")
		set_player(body)
		update_path()
		$PathTimer.start()
		state = states.action

func disable_collider() -> void:
	set_collision_layer_bit(0, false)
	set_collision_mask_bit(0, false)
	z_index = 1
	state = states.dead
	set_process(false)
