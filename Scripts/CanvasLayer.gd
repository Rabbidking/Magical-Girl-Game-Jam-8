extends CanvasLayer

signal add_item

var inventory_sub = false
var shop_sub = false

@onready var inventory = $Inventory_GUI
@onready var shop = $Shop_GUI
@onready var battle = $Battle_GUI

func _ready():
	inventory.close()
	shop.close()
	
func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		if inventory.is_open:
			inventory.close()
		else:
			inventory.open()
	
	if event.is_action_pressed("add_item"):
		add_item.emit()
		
	if event.is_action_pressed("Exit"):
		if inventory_sub == true:
			inventory.close()
	
		if shop_sub == true:
			shop.close()
			
			
func _on_battle_gui_open_inventory():
	inventory_sub = true
	
	
func _on_battle_gui_open_shop():
	shop_sub = true
	
	
func _on_inventory_gui_closed():
	battle.open()
	
	
func _on_shop_gui_closed():
	battle.open()
	


func _on_item_pressed():
	inventory_sub = true
