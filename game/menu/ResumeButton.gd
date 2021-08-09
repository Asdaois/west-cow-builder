# class_name
extends Button

# custom signals

# enums - constant

# exports variables

# public - private variables

# on ready variables
func _ready() -> void:
	connect('button_down', self, '_on_button_down')
	GameStateManager.connect('game_over', self, '_disabled')

# built-in functions

# public - private functions


# signals handle

func _on_button_down() -> void:
	GameStateManager.resume_game()

func _disabled() -> void:
	disabled = true


func _on_Resume_visibility_changed() -> void:
	pass # Replace with function body.
