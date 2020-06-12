extends CanvasLayer

func _on_Button_pressed():
	print(get_parent().get_node("BulletSpawner").get_child_count())

func set_start_wave(value : int) -> void:
	$Round/RoundLabel.text = "Wave %s" % value
	$Round/RoundAnim.play("fade_in")

func set_end_wave(value : int) -> void:
	$Round/RoundLabel.text = "Wave %s cleared" % value
	$Round/RoundAnim.play("fade_in")

func set_score(value : int) -> void:
	$Score.text = "Zombies Killed : %s" % value

func _on_ObjectPoolAndNavigation_start_wave(wave):
	set_start_wave(wave)


func _on_ObjectPoolAndNavigation_end_wave(wave):
	set_end_wave(wave)


func _on_ObjectPoolAndNavigation_add_score(score):
	set_score(score)
