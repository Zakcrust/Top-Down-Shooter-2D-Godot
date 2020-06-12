extends KinematicBody2D

class_name Enemies

var health 			  : int
var damage_resistance : int

func _init(default_health = 0, default_damage_resistance = 0):
	health = default_health
	damage_resistance = default_damage_resistance

func set_health(value : int) -> void:
	health = value

func get_health() -> int:
	return health
	
func set_damage_resistance(value : int) -> void:
	damage_resistance = value

func get_damage_resistance() -> int:
	return damage_resistance
