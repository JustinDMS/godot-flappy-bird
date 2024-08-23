extends Node

const GAME_OVER_SCENE := preload("res://scenes/game_over.tscn")

@export var score_label : Label
@export var subviewport : SubViewport

func _ready() -> void:
	Game.main = self

func _input(event: InputEvent) -> void:
	if event.is_action("quit"):
		Game.quit()
	
	subviewport.push_input(event)

func show_game_over() -> void:
	var scene := GAME_OVER_SCENE.instantiate()
	add_child(scene)

func update_score() -> void:
	score_label.text = str(Game.score)
