extends Area2D

var player_in_zone: bool = false

@onready var interaction_label = $InteractionLabel 

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	if interaction_label:
		interaction_label.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_in_zone = true
		if interaction_label:
			interaction_label.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_in_zone = false
		if interaction_label:
			interaction_label.visible = false

func _input(event: InputEvent) -> void:
	# Якщо натиснуто F і гравець поруч
	if event.is_action_pressed("use_fish") and player_in_zone:
		_execute_fish_removal()

func _execute_fish_removal() -> void:
	if Global.inventory.has("Риба"):
		Global.inventory.erase("Риба")
		print("Рибу доставлено")
		

		var inv_ui = get_tree().root.find_child("InventoryUI", true, false)
		
		if inv_ui and inv_ui.has_method("update_ui"):
			inv_ui.update_ui()
		else:


			var ui_nodes = get_tree().get_nodes_in_group("ui")
			for node in ui_nodes:
				if node.has_method("update_ui"):
					node.update_ui()
	else:
		print("У вас немає риби для доставки!")
