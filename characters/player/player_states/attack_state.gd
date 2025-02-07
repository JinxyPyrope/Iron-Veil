extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D

var combo_stage: int = 1  # Track which attack we're on
@export var combo_timer: Timer
@export var attack_timer: Timer

func _ready() -> void:
	pass

func on_process(_delta : float):
	pass

func on_physics_process(delta : float):
	# Remove the input check from here; we want immediate transition from enter()
	if combo_timer.is_stopped():
		print("Combo timer ended!")
		transition.emit("Idle")

func enter():
	print("Parent Attack State Enter Started")
	start_attack(combo_stage)
	
	# Immediately transition to the first attack when entering the Attack state
	print("Auto-transitioning to Attack1")
	transition.emit("attack1")

func exit():
	pass

func start_attack(stage):
	combo_timer.start(0.9)
	print("Combo Timer Started with wait time:", combo_timer)
