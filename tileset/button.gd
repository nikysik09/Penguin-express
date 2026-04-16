extends Area2D

const FISHING_SCENE = "res://fishing/area_2d.tscn"

@onready var prompt = $E 
var is_player_near = false
var current_player = null 

func _ready() -> void:
	if prompt:
		prompt.hide()
	
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
	if not body_exited.is_connected(_on_body_exited):
		body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		is_player_near = true
		current_player = body
		if prompt: prompt.show()

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		is_player_near = false
		current_player = null
		if prompt: prompt.hide()

func _process(_delta: float) -> void:
	if is_player_near and Input.is_action_just_pressed("interact"):
		if ResourceLoader.exists(FISHING_SCENE):
			if current_player:
				Global.player_position = current_player.global_position
			
			var result = get_tree().change_scene_to_file(FISHING_SCENE)
			if result != OK:
				print("Помилка: Сцена знайдена, але є пошкоджені ресурси (червоні помилки в консолі)")
		else:
			print("Помилка: Файл не знайдено за шляхом: ", FISHING_SCENE)
