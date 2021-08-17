# class_name
extends Button

# custom signals

# enums - constant

# exports variables

# public - private variables

# on ready variables
func _ready() -> void:
	assert(connect('button_down', self, '_on_button_down') == 0)

# built-in functions

# public - private functions

# signals handlers

func _on_button_down():
	GameStateManager.exit_game()
