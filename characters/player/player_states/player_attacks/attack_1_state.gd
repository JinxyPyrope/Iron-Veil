extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var combo_timer: Timer
@export var attack_timer: Timer

func on_process(delta: float):
	if attack_timer.is_stopped():
		print("Attack1 finished. Checking combo window...")
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
	
	combo_timer.start(.5)
	print("Combo Timer started for 1 second in Attack1")

func exit():
	print("Exiting Attack1 state")
	animated_sprite_2d.stop()
