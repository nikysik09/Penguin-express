extends CanvasLayer

func _on_start_pressed():
	get_tree().change_scene_to_file("res://tileset/tile_map_layer.tscn")
	print("Запуск гри...")

func _on_setting_pressed():
	print("Відкриваємо налаштування")
func _on_exit_pressed():
	print("Вихід з гри")
	get_tree().quit()
