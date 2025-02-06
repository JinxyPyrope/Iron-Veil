extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D


@export_category("Jump State")
@export var jump_height : float = -250
@export var jump_horizontal_speed : int = 500
@export var max_jump_horizontal_speed : int = 300
@export var max_jump_count : int = 1 

func on_process(delta : float):
	pass
	
func on_physics_process(delta : float):
	pass
	
func enter():
	pass
	
func exit():
	pass
