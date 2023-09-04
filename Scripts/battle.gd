extends Control

signal textbox_closed

@export var enemy: Resource = null

@onready var inventory = $ItemsPanel/Inventory_GUI

var cur_player_health = 0
var cur_enemy_health = 0
var is_defending = false

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
	
func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = " HP: %d/%d" % [health, max_health]
	
func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $Text.visible:
		$Text.hide()
		emit_signal("textbox_closed")
		
	
func display_text(text):
	$ActionsPanel.hide()
	$Text.show()
	$Text/Label.text = text
	
func enemy_turn():
	#display some text
	var enemy_attack = randi() % 4
	
	match enemy_attack:
		0:
			display_text("%s launches at you fiercely!" % enemy.name)
			await textbox_closed
			
			if is_defending:
				is_defending = false
				
				$AnimationPlayer.play("mini_shake")
				await $AnimationPlayer.animation_finished
				
				display_text("You defended successfully!")
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
				is_defending = false
				
				$AnimationPlayer.play("mini_shake")
				await $AnimationPlayer.animation_finished
				
				display_text("You defended successfully!")
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
				is_defending = false
				
				$AnimationPlayer.play("mini_shake")
				await $AnimationPlayer.animation_finished
				
				display_text("You defended successfully!")
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
				is_defending = false
				
				$AnimationPlayer.play("mini_shake")
				await $AnimationPlayer.animation_finished
				
				display_text("You defended successfully!")
				await textbox_closed
				
			else:
				#player health decreases
				cur_player_health = max(0, cur_player_health - enemy.damage4)
				set_health($PlayerPanel/PlayerData/ProgressBar, cur_player_health, State.max_health)
				
				$AnimationPlayer.play("shake")
				await $AnimationPlayer.animation_finished
			
				display_text("%s dealt %d damage!" % [enemy.name.to_upper(), enemy.damage4])
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


func _process(delta):
	pass


func _on_run_pressed():
	display_text("Got away safely!")
	await textbox_closed
	await get_tree().create_timer(0.25).timeout
	get_tree().quit()


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
	
	if cur_enemy_health == 0:
		display_text("%s has been defeated!" % enemy.name.to_upper())
		await textbox_closed
		
		$AnimationPlayer.play("enemy_die")
		await $AnimationPlayer.animation_finished
		await get_tree().create_timer(0.25).timeout
		get_tree().quit()
	
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


func _on_shop_gui_opened():
	$ItemsPanel.visible = true


func _on_shop_gui_closed():
	$ItemsPanel.visible = false


func _on_inventory_gui_item_used(item):
	$ItemsPanel.visible = false
	if item == "cupcake":
		display_text("Used cupcake")
		cur_player_health = max(0, cur_player_health + 20)
		set_health($PlayerPanel/PlayerData/ProgressBar, cur_player_health, State.max_health)
	await textbox_closed
	await get_tree().create_timer(0.25).timeout
	enemy_turn()

