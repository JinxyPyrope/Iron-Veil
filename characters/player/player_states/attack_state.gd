extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D

func _process(delta: float):
	pass
	
func on_physics_process(delta : float):
	pass

func enter():
	print("Parent Attack State Enter Started")
	if GameInputEvents.attack_input():
		print("Attack input detected! Transitioning to Attack1.")
		transition.emit("Attack1")

func exit():
	pass
