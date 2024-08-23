extends Control

@export var try_again : Button
@export var quit : Button

func _ready() -> void:
	try_again.pressed.connect(Game.reset)
	quit.pressed.connect(Game.quit)
