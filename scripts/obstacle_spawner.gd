extends Node2D

const MIN_SPAWN_TIME := 1.5
const MAX_SPAWN_TIME := 2.0

@export var spawn_timer : Timer

@onready var obstacle := preload("res://scenes/obstacle.tscn")

func _ready() -> void:
	spawn_timer.process_callback = Timer.TIMER_PROCESS_PHYSICS
	spawn_timer.timeout.connect(spawn_obstacle)
	
	spawn_obstacle()

func spawn_obstacle() -> void:
	var new_obstacle := obstacle.instantiate()
	add_child(new_obstacle)
	
	var time := randf_range(MIN_SPAWN_TIME, MAX_SPAWN_TIME)
	spawn_timer.start(time)
