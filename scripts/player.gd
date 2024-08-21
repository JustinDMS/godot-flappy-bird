extends CharacterBody2D

const GRAVITY := 1500.0
const JUMP_SPEED := 500.0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("jump"):
		if event.is_pressed() and not event.is_echo():
			velocity.y = -JUMP_SPEED

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	move_and_slide()
	
	if get_slide_collision_count() >= 1:
		Game.game_over()
