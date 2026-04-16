extends Area2D

const WORLD_SCENE = "res://tileset/tile_map_layer.tscn"

func _on_exit_button_up() -> void:
	get_tree().change_scene_to_file(WORLD_SCENE)
