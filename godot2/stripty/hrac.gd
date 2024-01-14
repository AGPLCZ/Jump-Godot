extends KinematicBody2D

var rychlost = 500
var pohyb = Vector2()
var gravitace = 2000
var speed_animation = 5
var jump = -1000
var smer = "right"
var smer_strela = 1

var scena_strela = preload("res://sceny/stela.tscn")



func _physics_process(delta):
	pohyb.y += gravitace*delta


	
	if Input.is_action_pressed("ord_l"):
		$player_sprite.flip_h = true
		
		
	
	if Input.is_action_pressed("vk_end"):
		get_tree().quit()
		
	if Input.is_action_pressed("ord_r"):
		get_tree().reload_current_scene()
	
	
	if is_on_wall():
		pohyb.x = 0
		get_node("player_sprite").speed_scale = 0
	
	if is_on_floor():
			
			
		if Input.is_action_pressed("vk_up"):
			pohyb.y = jump
			#$theme.play()
			
			

	if Input.is_action_pressed("vk_left"):
		pohyb.x = -rychlost
		smer = "left"
		smer_strela = -1
		
		get_node("player_sprite").playing=true
		if !is_on_floor():
			get_node("player_sprite").speed_scale = 0
			get_node("player_sprite").animation = "jump_left"
		else:
			get_node("player_sprite").speed_scale = speed_animation
			get_node("player_sprite").animation = "sprint_left"
			
	elif Input.is_action_pressed("ui_right"):
		pohyb.x = rychlost	
		smer = "right"
		smer_strela = 1
		
		get_node("player_sprite").playing=true
		if !is_on_floor():
			get_node("player_sprite").speed_scale = 0
			get_node("player_sprite").animation = "jump_right"
		else:
			get_node("player_sprite").speed_scale = speed_animation
			get_node("player_sprite").animation = "sprint_right"
			
		
	else:
		pohyb.x = 0
		if smer == "left":
			#get_node("player_sprite").playing=true
			#get_node("player_sprite").speed_scale = speed_animation
			#get_node("player_sprite").animation = "stop_left"
			$player_sprite.play("stop_left")
			
		if smer == "right":
			get_node("player_sprite").playing=true
			get_node("player_sprite").speed_scale = speed_animation
			get_node("player_sprite").animation = "stop_right"

	if Input.is_action_just_pressed("vk_space"):
		var vystrel = scena_strela.instance()
		vystrel.position = $Vystrel.global_position
		vystrel.speed *= smer_strela
		$"../Strely".add_child(vystrel)	
		
	pohyb = move_and_slide(pohyb, Vector2(0,-1))
