extends Node

var main : Node = null

var score : int = 0

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if event.is_action("quit"):
		quit()

func increment_score() -> void:
	score += 1
	main.update_score()

func game_over() -> void:
	get_tree().set_pause(true)
	main.show_game_over()

func reset() -> void:
	score = 0
	
	get_tree().reload_current_scene()
	get_tree().set_pause(false)

func quit() -> void:
	get_tree().quit()
