extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var hitbox: Area2D 
@export var combo_timer: Timer
@export var attack_timer: Timer

@onready var collision_shape = hitbox.get_node("CollisionShape2D")

func on_process(delta : float):
	if attack_timer.is_stopped():
		print("Attack2 finished. Checking combo window...")
		hitbox.monitoring = false
		collision_shape.debug_color = Color(1, 1, 1, 0.2)  # Reset to light transparent white
		if !combo_timer.is_stopped():
			print("Combo window open. Waiting for next input...")
			if GameInputEvents.attack_input():
				print("Third attack detected! Transitioning to Attack3.")
				transition.emit("Attack3")
		else:
			print("Combo window closed. Returning to Idle.")
			transition.emit("Idle")
	
func enter():
	print("Entered Attack1 state")
	animated_sprite_2d.play("attack_2")
	
	attack_timer.wait_time = 0.1
	attack_timer.start()
	print("Attack2 Timer started for 0.2 seconds")
	
	combo_timer.start(.5)
	print("Combo Timer started for 1 second in Attack2")
	
	hitbox.monitoring = true
	collision_shape.debug_color = Color(1, 0, 0, 0.5)  # Red with 50% opacity
	hitbox.connect("body_entered", Callable(self, "_on_hitbox_body_entered"))
	
func exit():
	print("Exiting Attack2 state")
	animated_sprite_2d.stop()
	
	
