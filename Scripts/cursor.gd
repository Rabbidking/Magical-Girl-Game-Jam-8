extends TextureRect

@export var menu_parent_path : NodePath
#@export var cursor_offset : Vector2

@onready var menu_parent := get_node(menu_parent_path)

var cursor_index : int = 0
var enabled = false
var cursor_offset : Vector2

func _process(_delta):
	if enabled == true:
		var input := Vector2.ZERO
		
		if Input.is_action_just_pressed("Right"):
			input.x += 1
		
		if Input.is_action_just_pressed("Left"):
			input.x -= 1
			
		if Input.is_action_just_pressed("Up"):
			input.y -= 1
			
		if Input.is_action_just_pressed("Down"):
			input.y += 1
		
		if menu_parent is VBoxContainer:
			set_cursor_from_index(cursor_index + input.y)
			
		elif menu_parent is HBoxContainer:
			set_cursor_from_index(cursor_index + input.x)
			
		elif menu_parent is GridContainer:
			set_cursor_from_index(cursor_index + input.x + input.y * menu_parent.columns)
			
		if Input.is_action_just_pressed("Select"):
			var current_menu_item = get_menu_item_at_index(cursor_index)
			if current_menu_item != null:
				if current_menu_item.has_method("cursor_select"):
					current_menu_item.cursor_select()
		
func get_menu_item_at_index(index : int) -> Control: 
	if menu_parent == null:
		return null
		
	if index >= menu_parent.get_child_count() or index < 0:
		return null
		
	return menu_parent.get_child(index) as Control
	
	
func set_cursor_from_index(index : int) -> void:
	var menu_item := get_menu_item_at_index(index)
	
	if menu_item == null:
		return
		
	var position = menu_item.global_position
	var size = menu_item.size
	
	global_position = Vector2(position.x, position.y + size.y / 2) - (size / 2.0) - cursor_offset
	
	cursor_index = index
	
	
func cursor_enabled():
	enabled = true
	cursor_index = 0
	
func cursor_disabled():
	enabled = false
	
func shop_and_inventory_offset():
	cursor_offset.x += -32
	
func battle_offset():
	cursor_offset.x = -136
	
func boss_offset():
	cursor_offset.x += -128
	
func save_offset():
	cursor_offset.x = -40
