# class_name
extends Node

# custom signals
signal start_game
signal resume_game
signal game_is_paused
signal game_over
# enums - constant

enum GameState {
	PAUSE,
	PLAYING,
	GAME_OVER
}
# exports variables

# public - private variables
var current_state = GameState.PLAYING
# on ready variables

# built-in functions

func _init() -> void:
	pass


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('ui_pause'):
		_pause_game()
	pass
# public - private functions

func resume_game():
	emit_signal('resume_game')
	get_tree().paused = false
	current_state = GameState.PLAYING


func new_game():
	assert(get_tree().reload_current_scene() == 0)
	get_tree().paused = false
	emit_signal('start_game')
	current_state = GameState.PLAYING


func exit_game():
	get_tree().quit()


func game_over():
	emit_signal('game_over')
	current_state = GameState.GAME_OVER


func _pause_game():
	emit_signal('game_is_paused')
	get_tree().paused = true
	current_state = GameState.PAUSE

# signals handlers
