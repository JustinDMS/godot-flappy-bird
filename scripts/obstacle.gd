extends Node2D

const MIN_GAP : float = 200.0
const MAX_GAP : float = 500.0
const HEIGHT_MARGIN : float = 100.0
const SPEED := 200.0
const X_MIN := -128.0 ## Despawns after reaching this x position

@onready var top : Sprite2D = $top
@onready var bottom : Sprite2D = $bottom
@onready var score_area : Area2D = $score_area

func _ready() -> void:
	var gap := randf_range(MIN_GAP, MAX_GAP)
	top.position.y -= gap * 0.5
	bottom.position.y += gap * 0.5
	
	#print("Gap: ", gap)
	#print("Wiggle room: ", MAX_GAP - gap)
	
	var height := randf_range(0, (MAX_GAP - gap) - HEIGHT_MARGIN)
	position.y += randf_range(-height, height)
	
	score_area.body_entered.connect(score_area_entered, ConnectFlags.CONNECT_ONE_SHOT)

func _physics_process(delta: float) -> void:
	position.x -= SPEED * delta
	
	if global_position.x <= X_MIN:
		queue_free()

func score_area_entered(_body : Node2D) -> void:
	Game.increment_score()
