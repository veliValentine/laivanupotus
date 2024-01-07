class_name CoordinatesStorage
extends Node

var storage: Dictionary
var defaultValue

func _init(initialStorage: Dictionary = {}, defaultValue = null):
	storage = initialStorage
	defaultValue = defaultValue
	print(initialStorage, defaultValue)

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
	return object != defaultValue

func get_from_storage(position: Vector2):
	print(position, storage)
	return storage.get(position.x, {}).get(position.y, defaultValue)
