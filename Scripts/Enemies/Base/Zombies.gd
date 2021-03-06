extends Enemies

class_name Zombies

var SPEED 			 : int 	= 50
var patrol_direction : Vector2
var patrol_target : Vector2 = Vector2(20,20)
var state					= states.spawn
var player 			 : KinematicBody2D
var paths 			 : PoolVector2Array
const SCREEN_SIZE 	 : Vector2 = Vector2(960, 640)

signal check_enemy_spawn()


func _init(default_speed = 50):
	SPEED = default_speed



enum states {
	spawn, patrol, action, dead
}

func _ready():
	z_index = 2
	$Sprite.play("action")

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
		states.spawn:
			move_to_screen(delta)
		states.patrol:
			patrol(delta)
		states.action:
			action(delta)
		states.dead:
			pass


func action(delta):
	var move_distance = SPEED * delta
	look_at(player.position)
	move_along_path(move_distance)
	
func move_to_screen(delta):
	if position.x < 0:
		position += Vector2.RIGHT * SPEED * delta
	else:
		position -= Vector2.LEFT * SPEED * delta
	if position.x > 20 or position.x < 940:
		$PatrolTimer.start()
		state = states.patrol
		

func move_along_path(distance : float) -> void:
	if state == states.dead:
		return
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
	if path != null:
		set_paths(path)

func patrol_path(target_position) -> void:
	var path = get_parent().get_simple_path(global_position, target_position)
	if path != null:
		set_paths(path)

func player_discovered(body : KinematicBody2D) -> void:
	$PatrolTimer.stop()
	if state == states.dead:
		return
	set_player(body)
	update_path()
	$PathTimer.start()
	$Sprite.play("action")
	state = states.action

func _on_DetectRadius_body_entered(body):
	if body is Player and state == states.patrol:
		print("player detected")
		player_discovered(body)
#		get_tree().call_group("zombies", "player_discovered", body)
#		$Sounds.play_primary_sfx("scream")

func dead() -> void:
	set_collision_layer_bit(0, false)
	set_collision_mask_bit(0, false)
	z_index = 1
	state = states.dead
	$Sprite.play("idle")
	$Sounds.play_primary_sfx("death")
	$DeathSplat.show()
	$DeathSplat/SplatAnim.play("splat")
	emit_signal("check_enemy_spawn")


func is_dead() -> bool:
	return state == states.dead

func damage(damage : int) -> void:
	health -= (damage - damage_resistance)
	if health < 0:
		dead()
		
func patrol(delta) -> void:
	var move_distance = SPEED * delta
	look_at(global_position + patrol_direction)
	move_along_path(move_distance)
	position.x = clamp(position.x, 10, SCREEN_SIZE.x - 10)
	position.y = clamp(position.y, 10, SCREEN_SIZE.y - 10)

func choose(values : Array):
	values.shuffle()
	return values.front()

func _on_VisibilityNotifier2D_screen_entered():
	pass


func _on_PatrolTimer_timeout():
	patrol_direction = choose([Vector2(0,30),Vector2(0,-30),Vector2(-30,0),Vector2(30,0)])
	patrol_path(global_position + patrol_direction)


func _on_DetectRadius_area_entered(area):
	if area.get_parent() is Player and state == states.patrol:
		player_discovered(area.get_parent())
		get_tree().call_group("zombies", "player_discovered", area.get_parent())
		$Sounds.play_primary_sfx("scream")
		
