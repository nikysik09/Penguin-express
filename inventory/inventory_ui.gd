extends CanvasLayer

var fish_icon = preload("res://inventory/FishIcon.png") 

@onready var item_list: ItemList = $ItemList

func _ready() -> void:
	visible = false 


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory_key"):
		visible = !visible
		if visible:
			update_ui()
	
	if event.is_action_pressed("use_fish") and visible:
		if item_list == null: return
		
		var selected = item_list.get_selected_items()
		if selected.size() > 0:
			var index = selected[0]
			var item_name = item_list.get_item_text(index)
			
			if item_name == "Звичайна риба" or item_name == "Риба":
				if Global.inventory.has(item_name):
					Global.inventory.erase(item_name)
					update_ui()
					print("Рибу видалено!")

func update_ui() -> void:
	if item_list == null:
		return
	
	item_list.clear()
	
	if not Global.inventory:
		return

	for item_name in Global.inventory:
		if item_name == "Риба":
			item_list.add_item(item_name, fish_icon)
		else:
			item_list.add_item(str(item_name))
