extends Node

var DEFAULT_OFFSET_POSITION = Vector2(0,0)

func is_out_of_bounds(touch_position: Vector2, offset_position = DEFAULT_OFFSET_POSITION) -> bool:
	var scaled_position = touch_position - offset_position
	if scaled_position.x < 0:
		return true
	if scaled_position.y < 0:
		return true
	if scaled_position.x >= Settings.CELLS * Settings.CELL_SIZE:
		return true
	if scaled_position.y >= Settings.CELLS * Settings.CELL_SIZE:
		return true
	
	return false

func get_game_position(position: Vector2, offset_position = DEFAULT_OFFSET_POSITION) -> Vector2:
	var raw_position = position - offset_position
	var position_x = (int(raw_position.x) / Settings.CELL_SIZE) % Settings.CELL_SIZE
	var position_y = (int(raw_position.y) / Settings.CELL_SIZE) % Settings.CELL_SIZE
	var scaled_ship_position = Vector2(position_x, position_y)
	return scaled_ship_position
