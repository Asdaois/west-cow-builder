# class_name
extends Node

# custom signals
signal game_is_paused
signal player_died
signal start_game
signal resume_game
# enums - constant

enum GameState {
	PAUSE,
	PLAYING,
	PLAYER_DIE
}
# exports variables

# public - private variables

# on ready variables

# built-in functions

func _init() -> void:
	pass


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if Input.is_action_just_pressed('ui_pause'):
		_pause_game()
	pass
# public - private functions

func resume_game():
	emit_signal('resume_game')
	get_tree().paused = false


func new_game():
	get_tree().reload_current_scene()
	get_tree().paused = false
	emit_signal('start_game')


func exit_game():
	get_tree().quit()


func game_over():
	emit_signal('player_died')


func _pause_game():
	emit_signal('game_is_paused')
	get_tree().paused = true

# signals handlers
