extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D

@onready var combo_timer: Timer = get_parent().combo_timer
@onready var attack_timer: Timer = get_parent().attack_timer

func _ready():
	attack_timer.timeout.connect(_on_attack_timer_timeout)
	print("Attack1 state initialized with inherited timers!")

func enter():
	print("Entered Attack1 state")
	animated_sprite_2d.play("attack_1")

	# Set a custom duration for this attack
	attack_timer.wait_time = 0.5
	attack_timer.start()
	print("Attack1 Timer started for 0.5 seconds")

	# Instead of restarting, extend the combo timer
	if combo_timer.time_left > 0:
		combo_timer.start(combo_timer.time_left + 0.5)  # Add 0.5 seconds to the existing combo window
		print("Combo Timer extended in Attack1 by 0.5 seconds")
	else:
		combo_timer.start(1.0)
		print("Combo Timer started fresh for 1 second")

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

func _on_attack_timer_timeout():
	pass  # Optional, if you need specific timeout behavior separate from on_process

func exit():
	print("Exiting Attack1 state")
	animated_sprite_2d.stop()
