extends CanvasLayer

@onready var catch_bar: ProgressBar = %CatchBar

var onCatch := false
var catchSpeed := 70.0
var catchingValue := 0.0
var is_ending := false

func _physics_process(_delta: float) -> void:
	if is_ending: return

	if onCatch: 
		catchingValue += catchSpeed * _delta
	else: 
		catchingValue -= catchSpeed * _delta
	
	catchingValue = clamp(catchingValue, 0.0, 100.0)
	
	if catch_bar:
		catch_bar.value = catchingValue
	
	if catchingValue >= 100: 
		_game_end()

func _game_end() -> void:
	if is_ending: return
	is_ending = true
	
	var fish_name = "Риба"
	
	if Global.has_method("add_to_inventory"):
		Global.add_to_inventory(fish_name)
	else:
		Global.inventory.append(fish_name)
	
	print("Міні-гра: Рибу додано в інвентар: ", fish_name)

	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "offset", Vector2(0, 700), 0.5) 
	
	await tween.finished
	get_tree().paused = false
	
	var main_scene = "res://tileset/tile_map_layer.tscn"
	if ResourceLoader.exists(main_scene):
		get_tree().change_scene_to_file(main_scene)
	else:
		print("Помилка: Сцена за шляхом " + main_scene + " не існує!")

func _on_target_target_entered() -> void: onCatch = true
func _on_target_target_exited() -> void: onCatch = false
