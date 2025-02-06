extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D

func on_process(delta : float):
	pass
	
func on_physics_process(delta: float) -> void:
	if not character_body_2d.is_on_floor():
		character_body_2d.velocity.y += character_body_2d.gravity * delta
	
	character_body_2d.move_and_slide()
	
	#run state
	var direction : float = GameInputEvents.movement_input()
	
	if direction and character_body_2d.is_on_floor():
		transition.emit("Run")
	
func enter():
	animated_sprite_2d.play("idle")
	
func exit():
	pass
