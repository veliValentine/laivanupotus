extends Node

@export var ships: Dictionary = {}

@export var is_place_ships_enabled = false

@export var SEA_POSITION: Vector2

signal ship_placed

func _input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			handle_ship_placements(event.position)

func handle_ship_placements(touch_position: Vector2):
	if not is_place_ships_enabled:
		return
	if is_out_of_bounds(touch_position):
		return
	var ship_position = get_ship_position_from_touch(touch_position)
	if contains_ship(ship_position):
		remove_ship(ship_position)
	else:
		add_ship(ship_position)
	ship_placed.emit()

func is_out_of_bounds(touch_position: Vector2) -> bool:
	var scaled_position = touch_position - SEA_POSITION
	if scaled_position.x < 0:
		return true
	if scaled_position.y < 0:
		return true
	if scaled_position.x >= Settings.CELLS * Settings.CELL_SIZE:
		return true
	if scaled_position.y >= Settings.CELLS * Settings.CELL_SIZE:
		return true
	
	return false

func get_ship_position_from_touch(touch_position: Vector2) -> Vector2:
	var raw_ship_position = touch_position - SEA_POSITION
	var ship_position_x = (int(raw_ship_position.x) / Settings.CELL_SIZE) % Settings.CELL_SIZE
	var ship_position_y = (int(raw_ship_position.y) / Settings.CELL_SIZE) % Settings.CELL_SIZE
	var scaled_ship_position = Vector2(ship_position_x, ship_position_y)
	return scaled_ship_position

func remove_ship(ship_position: Vector2):
	if not contains_ship(ship_position):
		return
	var ships_x = ships.get(ship_position.x)
	ships_x.erase(ship_position.y)

func add_ship(ship_position: Vector2):
	var ships_x = ships.get(ship_position.x, {})
	ships_x[ship_position.y] = true
	ships[ship_position.x] = ships_x
	
func contains_ship(ship_position: Vector2) -> bool:
	var is_ship = ships.get(ship_position.x, {}).get(ship_position.y, false)
	return is_ship
