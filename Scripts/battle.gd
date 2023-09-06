extends Control

signal textbox_closed

@export var enemy: Resource = null

@onready var inventory = $ItemsPanel/Inventory_GUI
@onready var cursor = $ActionsPanel/Cursor

var cur_player_health = 0
var cur_enemy_health = 0
var is_defending = false
var wearing_apron = false
var apron_counter = 0
var is_paralyzed = false
var paralysis_count = 0
var is_burning = false
var burn_count = 0
var is_poisoned = false
var poison_count = 0
var is_blinded = false
var blind_count = 0

func _ready():
	randomize()
	set_health($PlayerPanel/PlayerData/ProgressBar, State.cur_health, State.max_health)
	set_health($EnemyContainer/ProgressBar, enemy.health, enemy.health)
	$EnemyContainer/Enemy.texture = enemy.texture
	
	#initalize healths
	cur_player_health = State.cur_health
	cur_enemy_health = enemy.health
	
	$Text.hide()
	$ActionsPanel.hide()
	
	display_text("A wild %s appears!" % enemy.name.to_upper())
	await textbox_closed
	$ActionsPanel.show()
	$CursorBuffer.start()
	
func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = " HP: %d/%d" % [health, max_health]
	
func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $Text.visible or Input.is_action_just_pressed("Select"):
		$Text.hide()
		emit_signal("textbox_closed")
		
	
func display_text(text):
	$ActionsPanel.hide()
	$Text.show()
	$Text/Label.text = text
	
func enemy_turn():
	#display some text
	
	if is_burning == true:
		burn_count -= 1
		cur_enemy_health = max(0, cur_enemy_health - 10)
		set_health($EnemyContainer/ProgressBar, cur_enemy_health, enemy.health)
		display_text("%s takes burn damage" % enemy.name)
		await textbox_closed
		if burn_count <= 0:
			is_burning = false
			display_text("%s is no longer burning" % enemy.name)
			await textbox_closed
	
	if is_poisoned == true:
		poison_count -= 1
		cur_enemy_health = max(0, cur_enemy_health - 5)
		set_health($EnemyContainer/ProgressBar, cur_enemy_health, enemy.health)
		display_text("%s takes poison damage" % enemy.name)
		await textbox_closed
		if poison_count <= 0:
			is_poisoned = false
			display_text("%s is no longer poisoned" % enemy.name)
			await textbox_closed
			
	if is_blinded == true:
		display_text("%s can't see very well" % enemy.name)
		await textbox_closed
		enemy.accuracy = 20
		blind_count -= 1
		if blind_count <= 0:
			display_text("%s is no longer blinded" % enemy.name)
			await textbox_closed
			enemy.accuracy = 100
			
	if is_paralyzed == false:
		if randi() % 99 < enemy.accuracy:
			var enemy_attack = randi() % 4
			
			match enemy_attack:
				0:
					display_text("%s launches at you fiercely!" % enemy.name)
					await textbox_closed
					
					if is_defending:
						#is_defending = false
						
						$AnimationPlayer.play("mini_shake")
						await $AnimationPlayer.animation_finished
						
						apron_counter -= 1
						if apron_counter <= 0:
							wearing_apron = false
							is_defending = false
							display_text("Apron is destroyed")
							await textbox_closed
						else:
							display_text("Apron is still holding")
							await textbox_closed
							
						
					else:
						#player health decreases
						cur_player_health = max(0, cur_player_health - enemy.damage1)
						set_health($PlayerPanel/PlayerData/ProgressBar, cur_player_health, State.max_health)
						
						$AnimationPlayer.play("shake")
						await $AnimationPlayer.animation_finished
					
						display_text("%s dealt %d damage!" % [enemy.name.to_upper(), enemy.damage1])
						await textbox_closed
						
				1:
					display_text("%s lunges quickly!" % enemy.name)
					await textbox_closed
					
					if is_defending:
						#is_defending = false
						
						$AnimationPlayer.play("mini_shake")
						await $AnimationPlayer.animation_finished
						
						apron_counter -= 1
						if apron_counter <= 0:
							wearing_apron = false
							is_defending = false
							display_text("Apron is destroyed")
							await textbox_closed
						else:
							display_text("Apron is still holding")
							await textbox_closed
							
						
					else:
						#player health decreases
						cur_player_health = max(0, cur_player_health - enemy.damage2)
						set_health($PlayerPanel/PlayerData/ProgressBar, cur_player_health, State.max_health)
						
						$AnimationPlayer.play("shake")
						await $AnimationPlayer.animation_finished
					
						display_text("%s dealt %d damage!" % [enemy.name.to_upper(), enemy.damage2])
						await textbox_closed
						
				2:
					display_text("%s lets out a battle cry!" % enemy.name)
					await textbox_closed
					
					if is_defending:
						#is_defending = false
						
						$AnimationPlayer.play("mini_shake")
						await $AnimationPlayer.animation_finished
						
						apron_counter -= 1
						if apron_counter <= 0:
							wearing_apron = false
							is_defending = false
							display_text("Apron is destroyed")
							await textbox_closed
						else:
							display_text("Apron is still holding")
							await textbox_closed
							
						
					else:
						#player health decreases
						cur_player_health = max(0, cur_player_health - enemy.damage3)
						set_health($PlayerPanel/PlayerData/ProgressBar, cur_player_health, State.max_health)
						
						$AnimationPlayer.play("shake")
						await $AnimationPlayer.animation_finished
					
						display_text("%s dealt %d damage!" % [enemy.name.to_upper(), enemy.damage3])
						await textbox_closed
						
				3:
					display_text("%s swings its tail!" % enemy.name)
					await textbox_closed
					
					if is_defending:
						#is_defending = false
						
						$AnimationPlayer.play("mini_shake")
						await $AnimationPlayer.animation_finished
						
						apron_counter -= 1
						if apron_counter <= 0:
							wearing_apron = false
							is_defending = false
							display_text("Apron is destroyed")
							await textbox_closed
						else:
							display_text("Apron is still holding")
							await textbox_closed
							
					else:
						#player health decreases
						cur_player_health = max(0, cur_player_health - enemy.damage4)
						set_health($PlayerPanel/PlayerData/ProgressBar, cur_player_health, State.max_health)
						
						$AnimationPlayer.play("shake")
						await $AnimationPlayer.animation_finished
					
						display_text("%s dealt %d damage!" % [enemy.name.to_upper(), enemy.damage4])
						await textbox_closed
		
		else:
			display_text("%s attack missed" % enemy.name)
			await textbox_closed
			
	if is_paralyzed == true:
		display_text("%s is paralyzed" % enemy.name)
		await textbox_closed
		paralysis_count -= 1
		if paralysis_count <= 0:
			is_paralyzed = false
			display_text("%s is no longer paralyzed" % enemy.name)
			await textbox_closed
	#display_text("%s launches at you fiercely!" % enemy.name)
	#await textbox_closed
	
#	if is_defending:
#		is_defending = false
#
#		$AnimationPlayer.play("mini_shake")
#		await $AnimationPlayer.animation_finished
#
#		display_text("You defended successfully!")
#		await textbox_closed
#
#	else:
#		#player health decreases
#		cur_player_health = max(0, cur_player_health - enemy.damage)
#		set_health($PlayerPanel/PlayerData/ProgressBar, cur_player_health, State.max_health)
#
#		$AnimationPlayer.play("shake")
#		await $AnimationPlayer.animation_finished
#
#		display_text("%s dealt %d damage!" % [enemy.name.to_upper(), enemy.damage])
#		await textbox_closed
		
		
	$ActionsPanel.show()
	$CursorBuffer.start()

func _on_run_pressed():
	display_text("Got away safely!")
	await textbox_closed
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://Scenes/boss_select.tscn")


func _on_attack_pressed():
	#display some text
	display_text("You swing your sword!")
	await textbox_closed
	
	#enemy health decreases
	cur_enemy_health = max(0, cur_enemy_health - State.damage)
	set_health($EnemyContainer/ProgressBar, cur_enemy_health, enemy.health)
	
	$AnimationPlayer.play("enemy_damaged")
	await $AnimationPlayer.animation_finished
	
	display_text("You dealt %d damage!" % State.damage)
	await textbox_closed
	
	if cur_enemy_health <= 0:
		enemy_die()
	enemy_turn()
	


func _on_defend_pressed():
	is_defending = true
	display_text("You prepare defensively!")
	await textbox_closed
	await get_tree().create_timer(0.25).timeout
	enemy_turn()
	


func _on_item_pressed():
	pass # Replace with function body.
	
func _on_inventory_gui_opened():
	$ItemsPanel.visible = true
	
func _on_inventory_gui_closed():
	$ItemsPanel.visible = false
	$CursorBuffer.start()
	
func _on_shop_gui_opened():
	$ItemsPanel.visible = true
	
func _on_shop_gui_closed():
	$ItemsPanel.visible = false
	$CursorBuffer.start()
	
	
func _on_inventory_gui_item_used(item):
	$ItemsPanel.visible = false
	if item == "cupcake":
		display_text("You ate a cupcake and it healed %d points" % int(State.max_health * .75))
		cur_player_health = max(0, cur_player_health + (State.max_health * .75))
		if cur_player_health > State.max_health:
			cur_player_health = State.max_health
		set_health($PlayerPanel/PlayerData/ProgressBar, cur_player_health, State.max_health)
		await textbox_closed
		await get_tree().create_timer(0.25).timeout
		enemy_turn()
		
	elif item == "knife":
		display_text("You threw a knife")
		cur_enemy_health = max(0, cur_enemy_health - (State.damage * 2))
		set_health($EnemyContainer/ProgressBar, cur_enemy_health, enemy.health)
	
		$AnimationPlayer.play("enemy_damaged")
		await $AnimationPlayer.animation_finished
	
		display_text("You dealt %d damage!" % (State.damage *2))
		await textbox_closed
	
		if cur_enemy_health == 0:
			enemy_die()
		enemy_turn()
		
	elif item == "toaster":
		display_text("You threw a unstable toaster")
		cur_enemy_health = max(0, cur_enemy_health - State.damage)
		set_health($EnemyContainer/ProgressBar, cur_enemy_health, enemy.health)
	
		$AnimationPlayer.play("enemy_damaged")
		await $AnimationPlayer.animation_finished
	
		display_text("You dealt %d damage!" % State.damage)
		await textbox_closed
		
		if is_paralyzed == false:
			is_paralyzed = true
			paralysis_count = 4
			display_text("%s is paralzyed" % enemy.name)
			await textbox_closed
		else:
			display_text("%s is already paralzyed" % enemy.name)
			await textbox_closed
	
		if cur_enemy_health == 0:
			enemy_die()
		enemy_turn()
		
	elif item == "molotov":
		display_text("You threw a lit molotov")
		cur_enemy_health = max(0, cur_enemy_health - State.damage)
		set_health($EnemyContainer/ProgressBar, cur_enemy_health, enemy.health)
	
		$AnimationPlayer.play("enemy_damaged")
		await $AnimationPlayer.animation_finished
	
		display_text("You dealt %d damage!" % State.damage)
		await textbox_closed
		
		if is_burning == false:
			is_burning = true
			burn_count = 4
			display_text("%s is burning" % enemy.name)
			await textbox_closed
		else:
			display_text("%s is already burning" % enemy.name)
			await textbox_closed
		
		if cur_enemy_health == 0:
			enemy_die()
		enemy_turn()
		
	elif item == "poison":
		display_text("You splashed the enemy with extra strong rat poison")
		cur_enemy_health = max(0, cur_enemy_health - State.damage)
		set_health($EnemyContainer/ProgressBar, cur_enemy_health, enemy.health)
	
		$AnimationPlayer.play("enemy_damaged")
		await $AnimationPlayer.animation_finished
	
		display_text("You dealt %d damage!" % State.damage)
		await textbox_closed
		
		if is_poisoned == false:
			is_poisoned = true
			poison_count = 7
			display_text("%s has been poisoned" % enemy.name)
			await textbox_closed
		else:
			display_text("%s has already been poisoned" % enemy.name)
			await textbox_closed
		
		if cur_enemy_health == 0:
			enemy_die()
		enemy_turn()
		
	elif item == "spice":
		display_text("You threw spice powder at %s eyes" % enemy.name)
#		cur_enemy_health = max(0, cur_enemy_health - State.damage)
#		set_health($EnemyContainer/ProgressBar, cur_enemy_health, enemy.health)
#
#		$AnimationPlayer.play("enemy_damaged")
#		await $AnimationPlayer.animation_finished
#
#		display_text("You dealt %d damage!" % State.damage)
		await textbox_closed
		if is_blinded == false:
			is_blinded = true
			blind_count = 6
			display_text("%s has been blinded" % enemy.name)
			await textbox_closed
		else:
			display_text("%s has already been blinded" % enemy.name)
			await textbox_closed
	
		if cur_enemy_health == 0:
			enemy_die()
		enemy_turn()
		
	elif item == "mitts":
		var barrage = true
		var barrage_attack = randi() % 4
		var cur_attack = 0
		var max_attack = 3
		
		display_text("You unleashed a barrage of punches")
		
		for i in range(0, 2):
			cur_enemy_health = max(0, cur_enemy_health - State.damage)
			set_health($EnemyContainer/ProgressBar, cur_enemy_health, enemy.health)
	
			$AnimationPlayer.play("enemy_damaged")
			await $AnimationPlayer.animation_finished
	
			display_text("You dealt %d damage!" % State.damage)
			await textbox_closed
		
		while barrage == true:
			print("barrage mode")
			print(barrage_attack)
			if barrage_attack == 0:
				cur_enemy_health = max(0, cur_enemy_health - State.damage)
				set_health($EnemyContainer/ProgressBar, cur_enemy_health, enemy.health)
	
				$AnimationPlayer.play("enemy_damaged")
				await $AnimationPlayer.animation_finished
	
				display_text("You dealt %d damage!" % State.damage)
				await textbox_closed
				cur_attack += 1
				barrage_attack = randi() % 4
			
			elif cur_attack >= max_attack:
				barrage = false
				break
			
			else:
				barrage = false
				break
		
		if cur_enemy_health == 0:
			enemy_die()
		enemy_turn()
		
	elif item == "apron":
		if wearing_apron == false:
			wearing_apron = true
			apron_counter = 4
			is_defending = true
			display_text("You put on a protective apron")
			await textbox_closed
		else:
			display_text("You're already wearing an apron")
			await textbox_closed
			
		await get_tree().create_timer(0.25).timeout
		enemy_turn()
	

func enemy_die():
	#set flags for boss defeats
	match enemy.name:
		"Cockatrice":
			State.boss_1_def = true
		"Lizardwoman":
			State.boss_2_def = true
		"Harpy":
			State.boss_3_def = true
		"Lamia":
			State.boss_4_def = true
	
	display_text("%s has been defeated!" % enemy.name.to_upper())
	await textbox_closed

	$AnimationPlayer.play("enemy_die")
	await $AnimationPlayer.animation_finished
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://Scenes/boss_select.tscn")

func _on_attack_cursor_selected():
	cursor.cursor_disabled()
	_on_attack_pressed()

func _on_item_cursor_selected():
	cursor.cursor_disabled()
	_on_inventory_gui_opened()

func _on_shop_cursor_selected():
	cursor.cursor_disabled()
	_on_shop_gui_opened()

func _on_run_cursor_selected():
	cursor.cursor_disabled()
	_on_run_pressed()


func _on_cursor_buffer_timeout():
	cursor.cursor_enabled()
	cursor.battle_offset()
