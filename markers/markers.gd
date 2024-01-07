extends Node

@export var is_place_markers_enabled = false
@export var SEA_POSITION: Vector2

enum Markers { EMPTY = 0, MISS = 1,  HIT = 2 }

var coordinates: Coordinates
var marker_storage: CoordinatesStorage
var marker_type: Markers = Markers.EMPTY

signal marker_placed

func _ready():
	coordinates = preload("res://coordinates/coordinates.gd").new()
	marker_storage = preload("res://storage/coordinatesStorage.gd").new()
	marker_storage.set_default_value(Markers.EMPTY)

func _input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			handle_marker_placements(event.position)

func handle_marker_placements(touch_position: Vector2):
	if not is_place_markers_enabled:
		return
	if coordinates.is_out_of_bounds(touch_position, SEA_POSITION):
		return
	var marker_position = coordinates.get_game_position(touch_position, SEA_POSITION)
	var contains_same_marker = marker_type == marker_storage.get_from_storage(marker_position)
	if is_empty_marker(marker_type):
		marker_storage.remove(marker_position)
	elif contains_same_marker:
		marker_storage.remove(marker_position)
	else:
		marker_storage.add(marker_position, marker_type)
	marker_placed.emit()

func update_marker(marker: Markers):
	marker_type = marker

func get_storage():
	return marker_storage

func set_hit_markers():
	update_marker(Markers.HIT)

func set_miss_markers():
	update_marker(Markers.MISS)
	
func set_empty_markers():
	update_marker(Markers.EMPTY)

func is_empty_marker(input):
	return input == Markers.EMPTY

func is_miss_marker(input):
	return input == Markers.MISS

func is_hit_marker(input):
	return input == Markers.HIT
