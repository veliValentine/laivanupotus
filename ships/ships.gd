extends Node

@export var is_place_ships_enabled = false

@export var SEA_POSITION: Vector2

signal ship_placed

var coordinates: Coordinates
var storage: CoordinatesStorage

func _ready():
	coordinates = preload("res://coordinates/coordinates.gd").new()
	storage = preload("res://storage/coordinatesStorage.gd").new()
	storage.set_default_value(false)

func _input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			handle_ship_placements(event.position)

func handle_ship_placements(touch_position: Vector2):
	if not is_place_ships_enabled:
		return
	if coordinates.is_out_of_bounds(touch_position, SEA_POSITION):
		return
	var ship_position = coordinates.get_game_position(touch_position, SEA_POSITION)
	if storage.contains(ship_position):
		storage.remove(ship_position)
	else:
		storage.add(ship_position, true)
	ship_placed.emit()

func get_ships():
	return storage.get_all()

func remove_ships():
	storage.remove_all()
