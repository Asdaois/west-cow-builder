# class_name
extends Popup

# custom signals

# enums - constant

# exports variables

# public - private variables

# on ready variables

# built-in functions

func _ready() -> void:
	GameStateManager.connect('game_is_paused',self, "_show_menu")
	GameStateManager.connect('resume_game', self, "_hide_menu")
	GameStateManager.connect('game_over', self, "_show_menu")
	hide()
	pass

# public - private functions

func _show_menu() -> void:
	show()

func _hide_menu() -> void:
	hide()
	pass


# signals handlers


