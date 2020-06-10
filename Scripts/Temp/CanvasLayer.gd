extends CanvasLayer

func _on_Button_pressed():
	print(get_parent().get_node("BulletSpawner").get_child_count())
