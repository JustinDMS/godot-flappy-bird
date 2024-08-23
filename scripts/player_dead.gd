extends RigidBody2D

const FLAP_RATE : float = 0.1

var wing_down_offset := Vector2.ZERO
var is_down : bool = false

@export var timer : Timer

@onready var wing : Sprite2D = $Sprite2D/wing
@onready var wing_down : Texture2D = load("res://assets/wing_down.png")
@onready var wing_up : Texture2D = load("res://assets/wing_up.png")

func _ready() -> void:
	wing_down_offset = wing.offset
	
	timer.timeout.connect(flap)
	timer.start(FLAP_RATE)

func flap() -> void:
	if is_down:
		wing.texture = wing_down
		wing.offset = wing_down_offset
	else:
		wing.texture = wing_up
		wing.offset.y = wing_down_offset.y - (wing_down.get_height() * 0.5)
	
	is_down = !is_down
	timer.start(FLAP_RATE)
