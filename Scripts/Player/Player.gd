extends KinematicBody2D

class_name Player

export (int) var SPEED = 100

onready var screen_size = get_viewport_rect().size
onready var player_size = Vector2($Sprite.texture.get_width(), $Sprite.texture.get_height())
onready var boundaries : Dictionary = {
	"min" : Vector2(0 + (player_size.x / 2) ,0 + (player_size.y / 2)),
	"max" : Vector2(screen_size.x - (player_size.x / 2), screen_size.y - (player_size.y / 2))
}

var velocity = Vector2()
var state = states.hold

var equipped_gun = preload("res://Scripts/Guns/Pistol.gd").new()
var gun_damage : int
var gun_state
var can_shoot : bool = true

signal shoot(damage, bullet_position, bullet_direction)

enum states {
	hold, gun, dead
}

enum gun_states {
	semi, auto
}

func _ready():
	print(screen_size)
	print(boundaries)
	load_gun()

func _process(delta):
	match state:
		states.hold:
			_move(delta)
		states.gun:
			pass
		states.dead:
			pass
	match gun_state:
		gun_states.semi:
			manual_fire()
		gun_states.auto:
			auto_fire()


func _move(delta):
	velocity = Vector2()
	if Input.is_action_pressed("move_up"):
		velocity += transform.x * SPEED
	if Input.is_action_pressed("move_down"):
		velocity -= transform.x * SPEED
	move_and_collide(velocity * delta)
	position.x = clamp(position.x, boundaries["min"].x, boundaries["max"].x)
	position.y = clamp(position.y, boundaries["min"].y, boundaries["max"].y)
	look_at(get_global_mouse_position())

func load_gun():
	$WeaponSlot.texture = equipped_gun.get_image()
	gun_damage = equipped_gun.get_damage()
	if equipped_gun.get_auto():
		gun_state = gun_states.auto
	else:
		gun_state = gun_states.semi
	$Reload.set_wait_time(equipped_gun.get_reload_speed())

func manual_fire():
	if Input.is_action_just_pressed("fire") and can_shoot:
		can_shoot = false
		emit_signal("shoot", gun_damage, $WeaponSlot.global_position + Vector2(1, 0), $WeaponSlot.global_rotation)
		$Reload.start()
		pass

func auto_fire():
	if Input.is_action_pressed("fire") and can_shoot:
		can_shoot = false
		var direction = get_global_mouse_position().normalized()
		emit_signal("shoot", gun_damage, $WeaponSlot.global_position + Vector2(1, 0), $WeaponSlot.global_rotation)
		$Reload.start()
		pass

func _on_Reload_timeout():
	can_shoot = true
