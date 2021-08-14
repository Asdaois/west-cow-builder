# class_name
extends Button

# custom signals

# enums - constant

# exports variables

# public - private variables

# on ready variables


# built-in functions

func _init() -> void:
	pass


func _ready() -> void:
	assert(connect('button_down', self, '_on_button_down') == 0)


# public - private functions


# signals handlers

func _on_button_down():
	GameStateManager.new_game()
