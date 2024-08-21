extends Control

@onready var try_again : Button = $CenterContainer/VBoxContainer/try_again
@onready var quit : Button = $CenterContainer/VBoxContainer/quit

func _ready() -> void:
	try_again.pressed.connect(Game.reset)
	quit.pressed.connect(Game.quit)
