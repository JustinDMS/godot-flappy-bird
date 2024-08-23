extends CharacterBody2D

const GRAVITY := 1500.0
const JUMP_SPEED := 500.0

const MAX_TILT_FORWARD : float = 75.0 ## Degrees
const MAX_TILT_BACKWARD : float = -10.0 ## Degrees
const TILT_WEIGHT : float = 10.0

var wing_down_offset := Vector2.ZERO

@onready var sprite : Sprite2D = $Sprite2D
@onready var wing : Sprite2D = $Sprite2D/wing
@onready var wing_down : Texture2D = load("res://assets/wing_down.png")
@onready var wing_up : Texture2D = load("res://assets/wing_up.png")

func _ready() -> void:
	Game.player = self
	wing_down_offset = wing.offset

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("jump"):
		if event.is_pressed() and not event.is_echo():
			velocity.y = -JUMP_SPEED
			Game.play_sound(Game.JUMP)

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	move_and_slide()
	
	set_wing()
	# Rotate sprite based on velocity
	sprite.rotation_degrees = remap(velocity.y, -500, 1000, MAX_TILT_BACKWARD, MAX_TILT_FORWARD)
	
	if get_slide_collision_count() >= 1:
		Game.game_over()

func set_wing() -> void:
	if velocity.y < 0:
		wing.texture = wing_down
		wing.offset = wing_down_offset
	else:
		wing.texture = wing_up
		wing.offset.y = wing_down_offset.y - (wing_down.get_height() * 0.5)
