extends Control

signal opened
signal closed
signal item_used (value)
signal save_items1
signal save_items2
signal save_items3
signal save_items4
signal loaded_items
signal is_full
signal not_full

var save1 = false
var save2 = false
var save3 = false
var save4 = false
var is_open: bool = false
#var num = 0
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
	print(State.inv_count)
	update()

func update():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])
	if State.inv_count <= 8:
		not_full.emit()
	if State.inv_count >= 8:
		is_full.emit()
	
func open():
	visible = true
	is_open = true
	$Cursor.visible = true
	$NinePatchRect/GridContainer/Slot.enable_button()
	$NinePatchRect/GridContainer/Slot2.enable_button()
	$NinePatchRect/GridContainer/Slot3.enable_button()
	$NinePatchRect/GridContainer/Slot4.enable_button()
	$NinePatchRect/GridContainer/Slot5.enable_button()
	$NinePatchRect/GridContainer/Slot6.enable_button()
	$NinePatchRect/GridContainer/Slot7.enable_button()
	$NinePatchRect/GridContainer/Slot8.enable_button()
	$Timer.start()
	item = null
	opened.emit()
	
func open_noninteractive():
	visible = true
	is_open = true
	$Cursor.visible = false
	$NinePatchRect/GridContainer/Slot.disable_button()
	$NinePatchRect/GridContainer/Slot2.disable_button()
	$NinePatchRect/GridContainer/Slot3.disable_button()
	$NinePatchRect/GridContainer/Slot4.disable_button()
	$NinePatchRect/GridContainer/Slot5.disable_button()
	$NinePatchRect/GridContainer/Slot6.disable_button()
	$NinePatchRect/GridContainer/Slot7.disable_button()
	$NinePatchRect/GridContainer/Slot8.disable_button()
	
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
	
	
#Key Cursor Button Input
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
		State.inv_count -= 1
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
		State.inv_count -= 1
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
		State.inv_count -= 1
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
		State.inv_count -= 1
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
		State.inv_count -= 1
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
		State.inv_count -= 1
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
		State.inv_count -= 1
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
		State.inv_count -= 1
		update()
		use_item(item)
		
	else:
		print("nothing")
		
		
func _on_battle_gui_open_inventory():
	open()
	
func _on_item_cursor_selected():
	open()
	
func _on_timer_timeout():
	cursor.cursor_enabled()
	cursor.shop_and_inventory_offset()
	
	
func _on_shop_gui_add_cupcake():
	for i in range(min(inventory.items.size(), slots.size())):
		if inventory.items[i] == empty and State.inv_count <=8:
			inventory.items[i] = cupcake
			update()
			State.inv_count += 1
			if State.inv_count >= 8:
				is_full.emit()
				break
			break
			
		
func _on_shop_gui_add_knife():
	for i in range(min(inventory.items.size(), slots.size())):
		if inventory.items[i] == empty and State.inv_count <=8:
			inventory.items[i] = knife
			update()
			State.inv_count += 1
			if State.inv_count >= 8:
				is_full.emit()
				break
			break
			
func _on_shop_gui_add_toaster():
	for i in range(min(inventory.items.size(), slots.size())):
		if inventory.items[i] == empty and State.inv_count <=8:
			inventory.items[i] = toaster
			update()
			State.inv_count += 1
			if State.inv_count >= 8:
				is_full.emit()
				break
			break
			
func _on_shop_gui_add_molotov():
	for i in range(min(inventory.items.size(), slots.size())):
		if inventory.items[i] == empty and State.inv_count <=8:
			inventory.items[i] = molotov
			update()
			State.inv_count += 1
			if State.inv_count >= 8:
				is_full.emit()
				break
			break
			
func _on_shop_gui_add_poison():
	for i in range(min(inventory.items.size(), slots.size())):
		if inventory.items[i] == empty and State.inv_count <=8:
			inventory.items[i] = poison
			update()
			State.inv_count += 1
			if State.inv_count >= 8:
				is_full.emit()
				break
			break
			
func _on_shop_gui_add_spice():
	for i in range(min(inventory.items.size(), slots.size())):
		if inventory.items[i] == empty and State.inv_count <=8:
			inventory.items[i] = spice
			update()
			State.inv_count += 1
			if State.inv_count >= 8:
				is_full.emit()
				break
			break
			
func _on_shop_gui_add_mitts():
	for i in range(min(inventory.items.size(), slots.size())):
		if inventory.items[i] == empty and State.inv_count <=8:
			inventory.items[i] = mitts
			update()
			State.inv_count += 1
			if State.inv_count >= 8:
				is_full.emit()
				break
			break
			
func _on_shop_gui_add_apron():
	for i in range(min(inventory.items.size(), slots.size())):
		if inventory.items[i] == empty and State.inv_count <=8:
			inventory.items[i] = apron
			update()
			State.inv_count += 1
			if State.inv_count >= 8:
				is_full.emit()
				break
			break
			
			
func _on_item_pressed():
	open()

#Mouse Button Input
func _on_slot_button_pressed():
	_on_slot_cursor_selected()

func _on_slot_2_button_pressed():
	_on_slot_2_cursor_selected()

func _on_slot_3_button_pressed():
	_on_slot_3_cursor_selected()

func _on_slot_4_button_pressed():
	_on_slot_4_cursor_selected()

func _on_slot_5_button_pressed():
	_on_slot_5_cursor_selected()

func _on_slot_6_button_pressed():
	_on_slot_6_cursor_selected()

func _on_slot_7_button_pressed():
	_on_slot_7_cursor_selected()

func _on_slot_8_button_pressed():
	_on_slot_8_cursor_selected()

func load_select():
	for i in range(State.slot_array_def.size()):
		if State.slot_array_def[i] == "empty":
			inventory.items[i] = empty
		elif State.slot_array_def[i] == "cupcake":
			inventory.items[i] = cupcake
		elif State.slot_array_def[i] == "knife":
			inventory.items[i] = knife
		elif State.slot_array_def[i] == "toaster":
			inventory.items[i] = toaster
		elif State.slot_array_def[i] == "molotov":
			inventory.items[i] = molotov
		elif State.slot_array_def[i] == "poison":
			inventory.items[i] = poison
		elif State.slot_array_def[i] == "spice":
			inventory.items[i] = spice
		elif State.slot_array_def[i] == "mitts":
			inventory.items[i] = mitts
		elif State.slot_array_def[i] == "apron":
			inventory.items[i] = apron
		else:
			inventory.items[i] = empty
		loaded_items.emit()


func save_select():
	for i in range(min(inventory.items.size(), slots.size())):
		if inventory.items[i] == empty:
			State.slot_array_def[i] = "empty"
		elif inventory.items[i] == cupcake:
			State.slot_array_def[i] = "cupcake"
		elif inventory.items[i] == knife:
			State.slot_array_def[i] = "knife"
		elif inventory.items[i] == toaster:
			State.slot_array_def[i] = "toaster"
		elif inventory.items[i] == molotov:
			State.slot_array_def[i] = "molotov"
		elif inventory.items[i] == poison:
			State.slot_array_def[i] = "poison"
		elif inventory.items[i] == spice:
			State.slot_array_def[i] = "spice"
		elif inventory.items[i] == mitts:
			State.slot_array_def[i] = "mitts"
		elif inventory.items[i] == apron:
			State.slot_array_def[i] = "apron"
		else:
			State.slot_array_def[i] = "empty"
	print(State.slot_array_def)
	if save1 == true:
		save1 = false
		save_items1.emit()
	elif save2 == true:
		save2 = false
		save_items2.emit()
	elif save3 == true:
		save3 = false
		save_items3.emit()
	elif save4 == true:
		save4 = false
		save_items4.emit()


func _on_save_gui_save_slot_1():
	save1 = true
	save_select()
func _on_save_gui_save_slot_2():
	save2 = true
	save_select()
func _on_save_gui_save_slot_3():
	save3 = true
	save_select()
func _on_save_gui_save_slot_4():
	save4 = true
	save_select()


func _on_boss_select_load_file_1():
	load_select()
func _on_boss_select_load_file_2():
	load_select()
func _on_boss_select_load_file_3():
	load_select()
func _on_boss_select_load_file_4():
	load_select()

func _on_boss_gui_open_shop():
	open_noninteractive()

func _on_shop_gui_closed():
	close()

func _on_shop_gui_opened():
	open_noninteractive()
