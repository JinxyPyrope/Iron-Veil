extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var hitbox: Area2D 
@export var combo_timer: Timer
@export var attack_timer: Timer

@onready var collision_shape = hitbox.get_node("CollisionShape2D")

func on_process(delta: float):
	if attack_timer.is_stopped():
		print("Attack1 finished. Checking combo window...")
		hitbox.monitoring = false
		collision_shape.debug_color = Color(1, 1, 1, 0.2)  # Reset to light transparent white
		
		if !combo_timer.is_stopped():
			print("Combo window open. Waiting for next input...")
			if GameInputEvents.attack_input():
				print("Second attack detected! Transitioning to Attack2.")
				transition.emit("Attack2")
		else:
			print("Combo window closed. Returning to Idle.")
			transition.emit("Idle")

func on_physics_process(delta: float):
	pass

func enter():
	print("Entered Attack1 state")
	animated_sprite_2d.play("attack_1")
	
	attack_timer.wait_time = 0.2
	attack_timer.start()
	print("Attack1 Timer started for 0.2 seconds")

	combo_timer.start(0.5)
	print("Combo Timer started for 0.5 seconds in Attack1")
	
	hitbox.monitoring = true
	collision_shape.debug_color = Color(1, 0, 0, 0.5)  # Red with 50% opacity
	hitbox.connect("body_entered", Callable(self, "_on_hitbox_body_entered"))

func exit():
	print("Exiting Attack1 state")
	animated_sprite_2d.stop()
	
	hitbox.monitoring = false
	collision_shape.debug_color = Color(1, 1, 1, 0.2)  # Reset to light transparent white
