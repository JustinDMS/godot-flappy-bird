extends Node

const GAME_OVER_SCENE := preload("res://scenes/game_over.tscn")
const PLAYER_DEAD := preload("res://scenes/player_dead.tscn")

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
	
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(score_label, "scale", Vector2.ONE * 3, 1.0)

func update_score() -> void:
	score_label.text = str(Game.score)
	
	# Every 10 points
	if Game.score % 10 == 0:
		const DURATION : float = 0.3
		
		var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
		tween.tween_property(score_label, "scale", Vector2.ONE * 1.5, DURATION)
		tween.tween_property(score_label, "scale", Vector2.ONE, DURATION)

func show_player_dead(player : CharacterBody2D) -> void:
	var scene := PLAYER_DEAD.instantiate()
	subviewport.add_child(scene)
	scene.global_position = player.global_position
	scene.rotation = player.sprite.rotation
	
	Game.player.queue_free()
