extends Node

enum {
	SCORE,
	GAME_OVER,
	JUMP,
	HIT,
}

var main : Node = null
var player : CharacterBody2D = null

var score : int = 0

var sounds : Array[AudioStream] = [
	load("res://assets/220173__gameaudio__spacey-1uppower-up.wav"), #Spacey 1up/Power up by GameAudio -- https://freesound.org/s/220173/ -- License: Creative Commons 0
	load("res://assets/382310__mountain_man__game-over-arcade.wav"), #Game Over Arcade by Mountain_Man -- https://freesound.org/s/382310/ -- License: Creative Commons 0
	load("res://assets/237422__plasterbrain__hover-1.ogg"), #Hover 1 by plasterbrain -- https://freesound.org/s/237422/ -- License: Creative Commons 0
	load("res://assets/punch_trimmed.wav"), #punch.wav by Ekokubza123 -- https://freesound.org/s/104183/ -- License: Creative Commons 0, punches_and_slaps.wav by Syna-Max -- https://freesound.org/s/43586/ -- License: Attribution NonCommercial 4.0
]

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS

func increment_score() -> void:
	score += 1
	main.update_score()
	play_sound(SCORE)

func game_over() -> void:
	main.show_game_over()
	main.show_player_dead(player)
	play_sound(HIT)
	play_sound(GAME_OVER)

func reset() -> void:
	score = 0
	
	get_tree().reload_current_scene()

func quit() -> void:
	get_tree().quit()

func play_sound(type : int) -> void:
	var audio_stream := AudioStreamPlayer.new()
	add_child(audio_stream)
	
	audio_stream.stream = sounds[type]
	audio_stream.finished.connect(audio_stream.queue_free)
	
	# Adjust the sounds if needed
	match type:
		SCORE:
			audio_stream.volume_db = -8
		GAME_OVER:
			pass
		JUMP:
			audio_stream.volume_db = -7
			audio_stream.pitch_scale = randf_range(0.9, 1.2)
		HIT:
			audio_stream.volume_db = -12
	
	audio_stream.play()
