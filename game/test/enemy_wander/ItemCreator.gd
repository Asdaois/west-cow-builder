extends Node2D

func _ready() -> void:
	GameSignals.connect("instanciate_item_in_world", self, "_on_instantiate_item_in_world")


func _on_instantiate_item_in_world(Item, _position: Vector2):
	var item = Item.instance()
	get_parent().add_child(item)
	item.global_position = _position
	
	if item is RigidBody2D:
		print_debug("I'm a rigidbody")
