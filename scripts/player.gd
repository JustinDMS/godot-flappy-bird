extends CharacterBody2D

const GRAVITY := 1500.0
const JUMP_SPEED := 500.0

const MAX_TILT_FORWARD : float = 75.0 ## Degrees
const MAX_TILT_BACKWARD : float = -10.0 ## Degrees
const TILT_WEIGHT : float = 10.0

@onready var sprite : Sprite2D = $Sprite2D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("jump"):
		if event.is_pressed() and not event.is_echo():
			velocity.y = -JUMP_SPEED
			Game.play_sound(Game.JUMP)

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	move_and_slide()
	
	# Rotate sprite based on velocity
	sprite.rotation_degrees = remap(velocity.y, -500, 1000, MAX_TILT_BACKWARD, MAX_TILT_FORWARD)
	
	if get_slide_collision_count() >= 1:
		Game.game_over()
