# class_name
extends VBoxContainer

# custom signals

# enums - constant

# exports variables
export(Resource) var npc_weapons = npc_weapons as NpcWeapons
export(Resource) var nuggets = nuggets as ItemResource

# public - private variables
var _buttons
var _prices
var _weapon_names

# on ready variables
onready var nugget_label = $Label
onready var buy_button1 = $HBoxContainer/VBoxContainer/Button
onready var buy_button2 = $HBoxContainer/VBoxContainer2/Button
onready var buy_button3 = $HBoxContainer2/VBoxContainer/Button
onready var buy_button4 = $HBoxContainer2/VBoxContainer2/Button
onready var weapon_name1 = $HBoxContainer/VBoxContainer/HBoxContainer/WeaponName
onready var weapon_name2 = $HBoxContainer/VBoxContainer2/HBoxContainer/WeaponName
onready var weapon_name3 = $HBoxContainer2/VBoxContainer/HBoxContainer/WeaponName
onready var weapon_name4 = $HBoxContainer2/VBoxContainer2/HBoxContainer/WeaponName
onready var weapon_price1 = $HBoxContainer/VBoxContainer/HBoxContainer/WeaponPrice
onready var weapon_price2 = $HBoxContainer/VBoxContainer2/HBoxContainer/WeaponPrice
onready var weapon_price3 = $HBoxContainer2/VBoxContainer/HBoxContainer/WeaponPrice
onready var weapon_price4 = $HBoxContainer2/VBoxContainer2/HBoxContainer/WeaponPrice

# built-in functions
func _ready():
	_buttons = [buy_button1, buy_button2, buy_button3, buy_button4]
	_prices = [weapon_price1.text, weapon_price2.text, weapon_price3.text, weapon_price4.text]
	_weapon_names = [weapon_name1.text, weapon_name2.text, weapon_name3.text, weapon_name4.text]
	_update_store()

# public - private functions
func _update_store():
	nugget_label.text = "Your Gold: " + str(nuggets.quantity) + "N"
	_check_price()
	_check_availability()

func _check_price():
	for x in range(_prices.size()):
		if(float(_prices[x]) > nuggets.quantity):
			_buttons[x].text = "Not Enough Money"
			_buttons[x].disabled = true

func _check_availability():
	for x in range(_weapon_names.size()):
		if(_weapon_names[x] == npc_weapons.weapon_name):
			_buttons[x].text = "Already bought"
			_buttons[x].disabled = true

func _buy_weapon(weapon_name, weapon_price, weapon_damage):
	nuggets.quantity -= float(weapon_price)
	npc_weapons.weapon_name = weapon_name
	npc_weapons.weapon_damage = weapon_damage
	_update_store()

# signals handlers
func _on_buy_button1_pressed():
	_buy_weapon(weapon_name1.text, weapon_price1.text, 1)

func _on_buy_button2_pressed():
	_buy_weapon(weapon_name2.text, weapon_price2.text, 1.5)

func _on_buy_button3_pressed():
	_buy_weapon(weapon_name3.text, weapon_price3.text, 2)

func _on_buy_button4_pressed():
	_buy_weapon(weapon_name4.text, weapon_price4.text, 2.5)
