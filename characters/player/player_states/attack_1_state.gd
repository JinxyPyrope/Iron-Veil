extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var combo_timer: Timer  # Using the combo timer from the parent Attack state

var attack_timer: Timer  # Accessing the attack timer from the parent Attack state

func _ready():
	attack_timer = get_parent().attack_timer  # Reference the attack timer from the parent

func on_process(delta: float):
	# Check if attack animation is finished
	if attack_timer.is_stopped():
		print("Attack1 finished, checking combo timer...")

		# If combo timer is still running, allow for next attack
		if !combo_timer.is_stopped():
			print("Combo window still open! Waiting for next input.")
			# You can add more combo stages here later
		else:
			print("Combo window closed, returning to Idle.")
			transition.emit("Idle")  # Go back to Idle if combo window ended

func enter():
	print("Entered Attack1 state")
	animated_sprite_2d.play("attack_1")
	attack_timer.wait_time = 0.4  # Customize the attack duration for this attack
	attack_timer.start()  # Start the attack timer

func exit():
	print("Exiting Attack1 state")
	animated_sprite_2d.stop()  # Stop the animation when exiting
