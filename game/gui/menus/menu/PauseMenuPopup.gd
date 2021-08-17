# class_name
extends Popup

func _ready() -> void:
	assert(GameStateManager.connect('game_is_paused',self, "_show_menu") == 0)
	assert(GameStateManager.connect('resume_game', self, "_hide_menu") == 0)
	assert(GameStateManager.connect('game_over', self, "_show_menu") == 0)
	hide()
	pass

func _show_menu() -> void:
	show()

func _hide_menu() -> void:
	hide()
	pass


# signals handlers


