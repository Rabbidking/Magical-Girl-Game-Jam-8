extends Node2D

@export var inventory: Inventory
@export var battle_menu: Battle_Menu
@export var shop: Shop

func _on_inventory_gui_closed():
	get_tree().paused = false
	
	
func _on_inventory_gui_opened():
	get_tree().paused = true
