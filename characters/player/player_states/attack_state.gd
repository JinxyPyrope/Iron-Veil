extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D

@export var combo_timer: Timer
@export var attack_timer: Timer

func on_physics_process(delta: float):
	if combo_timer.is_stopped():
		print("Combo timer ended!")
		transition.emit("Idle")
	
	if combo_timer.is_stopped():
		transition.emit("Idle")

func enter():
	print("Parent Attack State Enter Started")
	start_attack()
	
func exit():
	pass

func start_attack():
	combo_timer.start(.5)  # Start with 1-second combo window (adjustable later)
	print("Combo Timer Started in Parent Attack")
	
	if GameInputEvents.attack_input() and !combo_timer.is_stopped():
		print("Attack input detected during combo window!")
		transition.emit("Attack1")
