extends Navigation2D

signal start_wave(wave)
signal end_wave(wave)

var left_side_spawn_point = Vector2(-600, 320)
var right_side_spawn_point = Vector2(1200, 320)

var zombie_spawn : int = DataManager.get_init_spawn()
var spawn_increment : float = DataManager.get_spawn_increment()
var offset_spawn_pool : int = 2
var wave : int = 1
var rng : RandomNumberGenerator
var current_score : int = 0

signal add_score(score)

var zombie : PackedScene = preload("res://Scenes/Enemies/NormalZombies.tscn")

func has_no_enemy() -> bool:
	var enemy_count = 0
	for enemy in get_children():
		if enemy is Zombies:
			if not enemy.is_dead():
				enemy_count += 1
	print("enemy left : %s" % enemy_count)
	return enemy_count == 0

func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	emit_signal("start_wave", wave)
	spawn_enemies()
	

func spawn_enemies():
	$Sounds.play_ambient_sfx("round_start")
	for i in range(1, zombie_spawn):
		var zombie_instance = zombie.instance()
		zombie_instance.connect("check_enemy_spawn", self, "check_enemy_spawn")
		if i % 2 == 0:
			zombie_instance.position = Vector2(left_side_spawn_point.x, rng.randi_range(10,620))
		else:
			zombie_instance.position = Vector2(right_side_spawn_point.x, rng.randi_range(10,620))
		add_child(zombie_instance)

func clear_enemy_instances():
	for enemy in get_children():
		if enemy is Zombies:
			enemy.queue_free()


func check_enemy_spawn() -> void:
	current_score += 1
	emit_signal("add_score", current_score)
	if has_no_enemy():
		$Sounds.play_ambient_sfx("round_end")
		emit_signal("end_wave", wave)
		wave += 1
		$SpawnClearedTimer.start()


func _on_SpawnClearedTimer_timeout():
	clear_enemy_instances()
	emit_signal("start_wave", wave)
	spawn_enemies()
