# class_name
extends VBoxContainer

# custom signals

# enums - constant

# exports variables
export(Resource) var player_nuggets = player_nuggets as ItemResource
export(Resource) var player_water = player_water as ItemResource
export(Resource) var player_capacity = player_capacity as ItemResource
export(Resource) var player_velocity = player_velocity as VelocityResource

# public - private variables
var _buttons
var _prices

# on ready variables
onready var player_gold = $PlayerGold/Gold

onready var water_upgrade_value = $WaterUpgrade/Description/UpgradeValueLabels/Value
onready var water_upgrade_cost = $WaterUpgrade/Description/UpgradeCostLabels/Cost
onready var water_upgrade_button = $WaterUpgrade/Description/Button

onready var capacity_upgrade_value = $CapacityUpgrade/Description/UpgradeValueLabels/Value
onready var capacity_upgrade_cost = $CapacityUpgrade/Description/UpgradeCostLabels/Cost
onready var capacity_upgrade_button = $CapacityUpgrade/Description/Button

onready var velocity_upgrade_value = $VelocityUpgrade/Description/UpgradeValueLabels/Value
onready var velocity_upgrade_cost = $VelocityUpgrade/Description/UpgradeCostLabels/Cost
onready var velocity_upgrade_button = $VelocityUpgrade/Description/Button

# built-in functions
func _ready() -> void:
	_initialize_arrays()
	_update_store()

# public - private functions
func _initialize_arrays():
	_buttons = [water_upgrade_button, capacity_upgrade_button, velocity_upgrade_button]
	_prices = [water_upgrade_cost.text, capacity_upgrade_cost.text, velocity_upgrade_cost.text]

func _check_price():
	for x in range(_prices.size()):
		if(float(_prices[x]) > player_nuggets.quantity):
			_buttons[x].text = "Not Enough Money"
			_buttons[x].disabled = true

func _update_store():
	player_gold.text = str(player_nuggets.quantity)
	_check_price()

func _buy_upgrade(upgrade_type, upgrade_cost, upgrade_value):
	player_nuggets.quantity -= upgrade_cost
	match upgrade_type:
		"Water":
			print(player_water.max_quantity)
			player_water.max_quantity += upgrade_value
			print(player_water.max_quantity)
		"Capacity":
			print(player_capacity.max_quantity)
			player_capacity.max_quantity += upgrade_value
			print(player_capacity.max_quantity)
		"Velocity":
			print(player_velocity.velocity)
			player_velocity.velocity *= upgrade_value
			print(player_velocity.velocity)
	_update_store()

# signals handlers
func _on_upgrade_button1_pressed():
	_buy_upgrade("Water", int(water_upgrade_cost.text), int(water_upgrade_value.text))

func _on_upgrade_button2_pressed():
	_buy_upgrade("Capacity", int(capacity_upgrade_cost.text), int(capacity_upgrade_value.text))
	
func _on_upgrade_button3_pressed():
	_buy_upgrade("Velocity", int(velocity_upgrade_cost.text), float(velocity_upgrade_value.text))
