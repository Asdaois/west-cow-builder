extends Node

export(Resource) var citizen = citizen as Citizen
export(NodePath) onready var label_name = get_node(label_name) as Label
export(NodePath) onready var label_job = get_node(label_job) as Label
export(NodePath) onready var avatar = get_node(avatar) as TextureRect

func set_citizen() -> void:
	label_name.text = citizen.citizen_name
	label_job.text = Enums.NPC_WORKS.keys()[citizen.current_job]
	avatar.texture = citizen.avatar

func _ready() -> void:
	set_citizen()
