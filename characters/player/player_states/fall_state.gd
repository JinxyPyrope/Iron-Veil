extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D

@export_category("Fall State")

@export var gravity: float = 980.0  # Adjust based on your needs

func on_process(delta : float):
	pass
	
func on_physics_process(delta : float):
	character_body_2d.velocity.y += gravity * delta
	
	character_body_2d.move_and_slide()
	
	
	#idle State transition
	if character_body_2d.is_on_floor():
		transition.emit("Idle")

		
func enter():
	animated_sprite_2d.play("fall")
	
func exit():
	animated_sprite_2d.stop()
