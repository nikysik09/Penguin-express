extends CanvasLayer

func _ready():
	offset.y = -700 
	hide()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	var new_pause_state = !get_tree().paused
	get_tree().paused = new_pause_state
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_ease(Tween.EASE_OUT)

	if new_pause_state:
		show()
		tween.tween_property(self, "offset:y", 0, 0.5)
	else:
		tween.tween_property(self, "offset:y", -700, 0.4)
		tween.finished.connect(hide)

func _on_resume_pressed():
	toggle_pause()

func _on_main_menu_pressed():
	get_tree().paused = false 
	get_tree().change_scene_to_file("res://menu/menu.tscn")

func _on_exit_pressed():
	get_tree().quit()
