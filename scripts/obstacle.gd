extends Node2D

const SPEED : float = 250.0
const X_MIN : float = -128.0 ## Despawns after reaching this x position

@onready var top : Sprite2D = $top
@onready var bottom : Sprite2D = $bottom
@onready var score_area : Area2D = $score_area

func _ready() -> void:
	var gap := get_random_gap_size()
	top.position.y -= gap * 0.5
	bottom.position.y += gap * 0.5
	
	position.y += get_random_gap_height(gap)
	
	score_area.body_entered.connect(score_area_entered, ConnectFlags.CONNECT_ONE_SHOT)

func _physics_process(delta: float) -> void:
	position.x -= SPEED * delta
	
	if global_position.x <= X_MIN:
		queue_free()

func score_area_entered(_body : Node2D) -> void:
	Game.increment_score()

## Get a gap size that is influenced by the current score
## Higher score == smaller gap
func get_random_gap_size() -> float:
	const MIN_GAP : float = 175.0
	const MAX_GAP : float = 450.0
	
	var max_gap : float = MAX_GAP - (snappedi(Game.score, 10) * 5)
	return randf_range(MIN_GAP, max(MIN_GAP, max_gap))

## Get an offset to add to the gap
func get_random_gap_height(gap : float) -> float:
	const MARGIN : float = 75.0
	
	var max_height : float = (360 - MARGIN) - (gap * 0.5)
	@warning_ignore("narrowing_conversion")
	var direction : int = pow(-1, randi() % 2) ## 1 or -1
	
	return randf_range(0, max_height) * direction
