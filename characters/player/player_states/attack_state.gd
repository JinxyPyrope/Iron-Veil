extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D

var combo_stage: int = 1
var combo_timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("parent attack state in")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
