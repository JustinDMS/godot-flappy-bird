extends Node2D

const SPAWN_TIME : float = 1.5

@export var spawn_timer : Timer

@onready var obstacle := preload("res://scenes/obstacle.tscn")

func _ready() -> void:
	spawn_timer.process_callback = Timer.TIMER_PROCESS_PHYSICS
	spawn_timer.timeout.connect(spawn_obstacle)
	
	spawn_obstacle()

func spawn_obstacle() -> void:
	var new_obstacle := obstacle.instantiate()
	add_child(new_obstacle)

	spawn_timer.start(SPAWN_TIME)
