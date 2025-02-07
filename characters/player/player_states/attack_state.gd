extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D

var combo_stage: int = 1  # Track which attack we're on
@export var combo_timer: Timer
@export var attack_timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#combo_timer = $ComboTimer
	#attack_timer = $AttackTimer
	print("Parent attack state initialized!")
	print("Combo Timer Connected:", combo_timer)

func on_process(_delta : float):
	pass

func on_physics_process(delta : float):
	if GameInputEvents.attack_input() and !combo_timer.is_stopped():
		print("Attack input detected during combo window!")
		transition.emit("Attack1")  # Move to Attack1 state
	
	if combo_timer.is_stopped():
		print("Combo timer ended!")
		transition.emit("Idle")  # Corrected signal for state transition

func enter():
	print("Parent Attack State Enter Started")
	start_attack(combo_stage)
	
func exit():
	pass

func start_attack(stage):
	combo_timer.start(0.3)
	print("Combo Timer Started with wait time:", combo_timer)
