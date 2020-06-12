extends Node

var init_enemy_spawn : int = 20
var spawn_increment : float = 1.2
var score : int = 0
func get_init_spawn() -> int:
	return init_enemy_spawn

func get_spawn_increment() -> float:
	return spawn_increment

func set_score(value : int) -> void:
	score = value

func add_score(value : int) -> void:
	score += value

func get_score() -> int:
	return score
