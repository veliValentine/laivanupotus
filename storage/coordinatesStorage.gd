class_name CoordinatesStorage
extends Node

var storage: Dictionary
var default_value

func _init(initialStorage: Dictionary = {}, defaultValue = null):
	storage = initialStorage
	default_value = defaultValue

func remove(position: Vector2):
	if not contains(position):
		return
	var position_x = storage.get(position.x)
	position_x.erase(position.y)

func add(position: Vector2, value):
	var position_x = storage.get(position.x, {})
	position_x[position.y] = value
	storage[position.x] = position_x
	
func contains(position: Vector2) -> bool:
	var object = get_from_storage(position)
	return object != default_value

func get_from_storage(position: Vector2):
	return storage.get(position.x, {}).get(position.y, default_value)

func get_all():
	return storage

func get_all_as_vectors():
	var vectors = []
	for x_key in storage:
		for y_key in storage[x_key]:
			var value = get_from_storage(Vector2(x_key, y_key))
			if value != default_value:
					vectors.append(Vector3(x_key, y_key, value))
	return vectors

func set_default_value(defaultValue):
	default_value = defaultValue

func remove_all():
	storage = {}
