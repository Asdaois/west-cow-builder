extends Node2D

func _ready() -> void:
	GameSignals.connect("instanciate_item_in_world", self, "_on_instantiate_item_in_world")


func _on_instantiate_item_in_world(Item, _position: Vector2):
	var item = Item.instance()
	get_parent().add_child(item)
	item.global_position = _position + Vector2.UP * 40
	
	if item is RigidBody2D:
		var force_applied_to_coin : Vector2 = Vector2(rand_range(-0.3 , 0.3), -1)
		item.apply_impulse(Vector2.ZERO, force_applied_to_coin * 80)
