extends Node2D
tool

const width_tile := 70

export(PackedScene) var dessert_scene : PackedScene
export(int) var floor_length setget set_floor_length

func set_floor_length(new_value: int) -> void:
	for child in get_children():
		(child as Node2D).queue_free()
	
	for i in range(new_value):
		var tile_dessert_position = Vector2(i * width_tile, 0)
		_add_floor(tile_dessert_position)
	
	_add_floor(Vector2(-width_tile, -width_tile))
	_add_floor(Vector2(new_value * width_tile, -width_tile))
	
	floor_length = new_value


func _add_floor(position: Vector2) -> void:
	var dessert_floor : Node2D = dessert_scene.instance()
	dessert_floor.position = position
	add_child(dessert_floor)
	pass
