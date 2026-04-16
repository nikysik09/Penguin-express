extends Node

var saved_time : int = 0
var player_position : Vector2 = Vector2.ZERO

var inventory : Array = []

func add_to_inventory(item_name: String):
	inventory.append(item_name)
	print("Предмет додано: ", item_name)

func remove_from_inventory(item_name: String):
	if inventory.has(item_name):
		inventory.erase(item_name)
		print("Предмет видалено: ", item_name)
	else:
		print("Предмета ", item_name, " немає в інвентарі!")

func clear_inventory():
	inventory.clear()
	print("Інвентар очищено")

func has_item(item_name: String) -> bool:
	return inventory.has(item_name)
