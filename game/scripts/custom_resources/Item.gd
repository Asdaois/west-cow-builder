class_name ItemResource 
extends Resource

# custom signals
signal quantity_emptied
signal quantity_changed(value)
signal max_quantity_changed(value)
# enums - constant

# exports variables
export(float) var quantity = 0 setget set_quantity
export(float) var max_quantity = 0 setget set_max_quantity

# public - private functions
func set_max_quantity(value):
	max_quantity = value
	self.quantity = min(quantity, max_quantity) as float
	emit_signal('max_quantity_changed', max_quantity)
	
func set_quantity(value):
	quantity = max(0, value)
	emit_signal('quantity_changed', quantity)
	if(quantity <= 0):
		emit_signal('quantity_emptied')

# signals handlers
