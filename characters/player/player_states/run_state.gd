extends NodeState

@export var character_body_2d: CharacterBody2D 
@export var animated_sprite_2d: AnimatedSprite2D 
@export var hitbox: Area2D  # Export the hitbox for access

@export_category("Run State")
@export var speed: int = 1000
@export var max_horizontal_speed: int = 300

# Store initial hitbox position for reference
@onready var initial_hitbox_position: Vector2 = hitbox.position

func on_physics_process(delta: float):
	var direction: float = GameInputEvents.movement_input()
	
	if direction:
		character_body_2d.velocity.x += direction * speed
		character_body_2d.velocity.x = clamp(character_body_2d.velocity.x, -max_horizontal_speed, max_horizontal_speed)
		
		# Flip the sprite based on movement
		animated_sprite_2d.flip_h = false if direction > 0 else true
		
		# Flip the hitbox position based on direction
		if direction > 0:
			hitbox.position.x = abs(initial_hitbox_position.x)  # Face right
		else:
			hitbox.position.x = -abs(initial_hitbox_position.x)  # Face left
			
	character_body_2d.move_and_slide()
	
	# Transition to idle when not moving
	if direction == 0:
		transition.emit("Idle")
		
	# Jump state
	if GameInputEvents.jump_input():
		transition.emit("Jump")

func enter():
	animated_sprite_2d.play('run')
	
func exit():
	animated_sprite_2d.stop()
