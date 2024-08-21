extends Node

const GAME_OVER_SCENE := preload("res://scenes/game_over.tscn")

@export var score_label : Label

func _ready() -> void:
	Game.main = self

func show_game_over() -> void:
	var scene := GAME_OVER_SCENE.instantiate()
	add_child(scene)

func update_score() -> void:
	score_label.text = "Score: %d" % [Game.score]
