extends Area2D

@export var hitbox: Area2D 

func on_physics_process(delta: float):
	var direction : float = GameInputEvents.movement_input()
	
	
