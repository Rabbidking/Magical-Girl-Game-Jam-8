extends Control

signal opened
signal closed
signal item_used (value)

var is_open: bool = false
var num = 0
var item

@onready var inventory: Inventory = preload("res://Inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var empty: Inventory_Item = preload("res://Inventory/Items/Empty.tres")
@onready var cupcake: Inventory_Item = preload("res://Inventory/Items/INV_Cupcake.tres")
@onready var knife: Inventory_Item = preload("res://Inventory/Items/INV_Kitchen Knife.tres")
@onready var toaster: Inventory_Item = preload("res://Inventory/Items/INV_Unstable Toaster.tres")
@onready var molotov: Inventory_Item = preload("res://Inventory/Items/INV_Molotov.tres")
@onready var poison: Inventory_Item = preload("res://Inventory/Items/INV_Rat Poison.tres")
@onready var spice: Inventory_Item = preload("res://Inventory/Items/INV_Spice.tres")
@onready var mitts: Inventory_Item = preload("res://Inventory/Items/INV_Oven Mitts.tres")
@onready var apron: Inventory_Item = preload("res://Inventory/Items/INV_Apron.tres")
@onready var cursor = $Cursor

func _ready():
	update()

func update():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])
	
func open():
	visible = true
	is_open = true
	$Timer.start()
	item = null
	opened.emit()
	
	
func close():
	visible = false
	is_open = false 
	cursor.cursor_disabled()
	closed.emit()
	
func use_item(item):
	visible = false
	is_open = false 
	cursor.cursor_disabled()
	item_used.emit(item)
	
	
func _on_canvas_layer_add_item():
	inventory.items[0] = cupcake
	print(inventory.items[0])
	update()
	
	
func _on_slot_cursor_selected():
	if inventory.items[0] != empty:
		if inventory.items[0] == cupcake:
			item = "cupcake"
		elif inventory.items[0] == knife:
			item = "knife"
		elif inventory.items[0] == toaster:
			item = "toaster"
		elif inventory.items[0] == molotov:
			item = "molotov"
		elif inventory.items[0] == poison:
			item = "poison"
		elif inventory.items[0] == spice:
			item = "spice"
		elif inventory.items[0] == mitts:
			item = "mitts"
		elif inventory.items[0] == apron:
			item = "apron"
		inventory.items[0] = empty
		update()
		use_item(item)
	else:
		print("nothing")

		
		
func _on_slot_2_cursor_selected():
	if inventory.items[1] != empty:
		if inventory.items[1] == cupcake:
			item = "cupcake"
		elif inventory.items[1] == knife:
			item = "knife"
		elif inventory.items[1] == toaster:
			item = "toaster"
		elif inventory.items[1] == molotov:
			item = "molotov"
		elif inventory.items[1] == poison:
			item = "poison"
		elif inventory.items[1] == spice:
			item = "spice"
		elif inventory.items[1] == mitts:
			item = "mitts"
		elif inventory.items[1] == apron:
			item = "apron"
		inventory.items[1] = empty
		update()
		use_item(item)
	else:
		print("nothing")

	
	
func _on_slot_3_cursor_selected():
	if inventory.items[2] != empty:
		if inventory.items[2] == cupcake:
			item = "cupcake"
		elif inventory.items[2] == knife:
			item = "knife"
		elif inventory.items[2] == toaster:
			item = "toaster"
		elif inventory.items[2] == molotov:
			item = "molotov"
		elif inventory.items[2] == poison:
			item = "poison"
		elif inventory.items[2] == spice:
			item = "spice"
		elif inventory.items[2] == mitts:
			item = "mitts"
		elif inventory.items[2] == apron:
			item = "apron"
		inventory.items[2] = empty
		update()
		use_item(item)
			
	else:
		print("nothing")

	
	
func _on_slot_4_cursor_selected():
	if inventory.items[3] != empty:
		if inventory.items[3] == cupcake:
			item = "cupcake"
		elif inventory.items[3] == knife:
			item = "knife"
		elif inventory.items[3] == toaster:
			item = "toaster"
		elif inventory.items[3] == molotov:
			item = "molotov"
		elif inventory.items[3] == poison:
			item = "poison"
		elif inventory.items[3] == spice:
			item = "spice"
		elif inventory.items[3] == mitts:
			item = "mitts"
		elif inventory.items[3] == apron:
			item = "apron"
		inventory.items[3] = empty
		update()
		use_item(item)
		
	else:
		print("nothing")

	
	
	
func _on_slot_5_cursor_selected():
	if inventory.items[4] != empty:
		if inventory.items[4] == cupcake:
			item = "cupcake"
		elif inventory.items[4] == knife:
			item = "knife"
		elif inventory.items[4] == toaster:
			item = "toaster"
		elif inventory.items[4] == molotov:
			item = "molotov"
		elif inventory.items[4] == poison:
			item = "poison"
		elif inventory.items[4] == spice:
			item = "spice"
		elif inventory.items[4] == mitts:
			item = "mitts"
		elif inventory.items[4] == apron:
			item = "apron"
		inventory.items[4] = empty
		update()
		use_item(item)
		
	else:
		print("nothing")

	
	
func _on_slot_6_cursor_selected():
	if inventory.items[5] != empty:
		if inventory.items[5] == cupcake:
			item = "cupcake"
		elif inventory.items[5] == knife:
			item = "knife"
		elif inventory.items[5] == toaster:
			item = "toaster"
		elif inventory.items[5] == molotov:
			item = "molotov"
		elif inventory.items[5] == poison:
			item = "poison"
		elif inventory.items[5] == spice:
			item = "spice"
		elif inventory.items[5] == mitts:
			item = "mitts"
		elif inventory.items[5] == apron:
			item = "apron"
		inventory.items[5] = empty
		update()
		use_item(item)
	
	else:
		print("nothing")

	
func _on_slot_7_cursor_selected():
	if inventory.items[6] != empty:
		if inventory.items[6] == cupcake:
			item = "cupcake"
		elif inventory.items[6] == knife:
			item = "knife"
		elif inventory.items[6] == toaster:
			item = "toaster"
		elif inventory.items[6] == molotov:
			item = "molotov"
		elif inventory.items[6] == poison:
			item = "poison"
		elif inventory.items[6] == spice:
			item = "spice"
		elif inventory.items[6] == mitts:
			item = "mitts"
		elif inventory.items[6] == apron:
			item = "apron"
		inventory.items[6] = empty
		update()
		use_item(item)
		
	else:
		print("nothing")

	
func _on_slot_8_cursor_selected():
	if inventory.items[7] != empty:
		if inventory.items[7] == cupcake:
			item = "cupcake"
		elif inventory.items[7] == knife:
			item = "knife"
		elif inventory.items[7] == toaster:
			item = "toaster"
		elif inventory.items[7] == molotov:
			item = "molotov"
		elif inventory.items[7] == poison:
			item = "poison"
		elif inventory.items[7] == spice:
			item = "spice"
		elif inventory.items[7] == mitts:
			item = "mitts"
		elif inventory.items[7] == apron:
			item = "apron"
		inventory.items[7] = empty
		update()
		use_item(item)
		
	else:
		print("nothing")

	
	
func _on_battle_gui_open_inventory():
	open()
	
func _on_timer_timeout():
	cursor.cursor_enabled()
	
	
func _on_shop_gui_add_cupcake():
	for i in range(min(inventory.items.size(), slots.size())):
		if inventory.items[i] == empty:
			inventory.items[i] = cupcake
			update()
			num = 0
			break
		
		elif num >= 8:
			print("full")
			num = 0
			break
			
		else:
			num += 1
			print(num)
			
func _on_shop_gui_add_knife():
	for i in range(min(inventory.items.size(), slots.size())):
		if inventory.items[i] == empty:
			inventory.items[i] = knife
			update()
			num = 0
			break
			
		elif num >= 8:
			print("full")
			num = 0
			break
			
		else:
			num += 1
			print(num)
			
func _on_shop_gui_add_toaster():
	for i in range(min(inventory.items.size(), slots.size())):
		if inventory.items[i] == empty:
			inventory.items[i] = toaster
			update()
			num = 0
			break
			
		elif num >= 8:
			print("full")
			num = 0
			break
			
		else:
			num += 1
			print(num)
			
func _on_shop_gui_add_molotov():
	for i in range(min(inventory.items.size(), slots.size())):
		if inventory.items[i] == empty:
			inventory.items[i] = molotov
			update()
			num = 0
			break
			
		elif num >= 8:
			print("full")
			num = 0
			break
			
		else:
			num += 1
			print(num)
			
func _on_shop_gui_add_poison():
	for i in range(min(inventory.items.size(), slots.size())):
		if inventory.items[i] == empty:
			inventory.items[i] = poison
			update()
			num = 0
			break
			
		elif num >= 8:
			print("full")
			num = 0
			break
			
		else:
			num += 1
			print(num)
			
func _on_shop_gui_add_spice():
	for i in range(min(inventory.items.size(), slots.size())):
		if inventory.items[i] == empty:
			inventory.items[i] = spice
			update()
			num = 0
			break
			
		elif num >= 8:
			print("full")
			num = 0
			break
			
		else:
			num += 1
			print(num)
			
func _on_shop_gui_add_mitts():
	for i in range(min(inventory.items.size(), slots.size())):
		if inventory.items[i] == empty:
			inventory.items[i] = mitts
			update()
			num = 0
			break
			
		elif num >= 8:
			print("full")
			num = 0
			break
			
		else:
			num += 1
			print(num)
			
func _on_shop_gui_add_apron():
	for i in range(min(inventory.items.size(), slots.size())):
		if inventory.items[i] == empty:
			inventory.items[i] = apron
			update()
			num = 0
			break
			
		elif num >= 8:
			print("full")
			num = 0
			break
			
		else:
			num += 1
			print(num)


func _on_item_pressed():
	open()
