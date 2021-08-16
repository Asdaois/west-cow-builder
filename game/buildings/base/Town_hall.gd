# class_name
extends StaticBody2D

# custom signals

# enums - constant

# exports variables
export var NUGGETS_EARNED = 3
export(Resource) var cows
export(Resource) var nuggets
export(PackedScene) var nugget_scene = preload("res://nugget/Nugget.tscn")
# public - private variables
var _delivery = false

# on ready variables
onready var label := $Label

func _ready() -> void:
	Globals.town_hall = self

func _input(_event):
	if(_delivery):
		if(Input.get_action_strength("ui_down")):
			var nuggest_quantity_earned :int = NUGGETS_EARNED * cows.quantity
			cows.quantity = 0
			for _i in range(nuggest_quantity_earned):
				yield(get_tree().create_timer(0.2), "timeout")
				_instantiate_nugget()
				

func _instantiate_nugget():
	GameSignals.emit_signal("instanciate_item_in_world", nugget_scene, global_position)

# signals handlers
func _on_DetectionArea_area_entered(area):
	if area.name == "PlayerArea":
		if(cows.quantity > 0):
			label.text = "Entregar Vacas"
			_delivery = true
		else:
			label.text = "No tienes vacas"


func _on_DetectionArea_area_exited(_area):
	label.text = ""
	_delivery = false
