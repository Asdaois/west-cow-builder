# class_name
extends StaticBody2D

# custom signals

# enums - constant

# exports variables
export var LEVEL = 1
export var FARMERS = 0
export var COWS = 0
export var NUGGETS_EARNED = 3
export(Resource) var cows = cows as ItemResource
export(PackedScene) var nugget_scene = preload("res://nugget/Nugget.tscn")

# public - private variables
var _deliverable = false

# on ready variables
onready var label = $Label
onready var label2 = $Label2
onready var label3 = $Label3
onready var label4 = $Label4

# built-in functions

func _init() -> void:
  pass

func _ready() -> void:
  _update_labels()

func _input(event):
	if(_deliverable):
		if event.is_action_pressed("ui_down"):
			var nuggest_quantity_earned :int = NUGGETS_EARNED * cows.quantity
			COWS += cows.quantity
			cows.quantity = 0
			_update_labels()
			label4.text = "Vacas entregadas"
			for _i in range(nuggest_quantity_earned):
				yield(get_tree().create_timer(0.2), "timeout")
				_instantiate_nugget()

# public - private functions
func _instantiate_nugget():
	GameSignals.emit_signal("instanciate_item_in_world", nugget_scene, global_position)

func _update_labels():
	label.text = "Level = " + str(LEVEL)
	label2.text = "Farmers = " + str(FARMERS)
	label3.text = "Cows = " + str(COWS)

# signals handlers
func _on_Area2D_body_entered(body):
	if body is Player:
		if cows.quantity > 0:
			label4.text = "Presiona v para\ndejar vacas"
			_deliverable = true
		else:
			label4.text = "No tienes vacas"
			_deliverable = false

func _on_Area2D_body_exited(body):
	if body is Player:
		label4.text = ""
		_deliverable = false
