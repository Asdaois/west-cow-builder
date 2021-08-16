extends Node

func disabled_node(node : Node):
	node.set_process(false)
	node.set_physics_process(false)
	node.set_process_input(false) 
	node.set_process_unhandled_key_input(false)
	node.set_process_unhandled_input(false)
	node.set_block_signals(true)


func enabled_node(node : Node):
	node.set_process(true)
	node.set_physics_process(true)
	node.set_process_input(true) 
	node.set_process_unhandled_key_input(true)
	node.set_process_unhandled_input(true)
	node.set_block_signals(false)
