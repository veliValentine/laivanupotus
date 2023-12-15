extends Node2D

@export var ship_scene: PackedScene

var cells: int = 10
var cell_size: int = 50

@export var HORIZONTAL_SHIP: Vector2 = Vector2(1,0)
@export var VERTICAL_SHIP: Vector2 = Vector2(0,1)

var is_place_ships: bool = false

var ships: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

func new_game():
	generate_ships()

func generate_ships():
	pass

func add_ship(start: Vector2, direction: Vector2, length: int):
	print(start, direction, length)
	for i in range(length):
		add_segment(start + direction * i)

func add_segment(segment_position: Vector2):
	print("poop",segment_position)
	ships.append(segment_position)
	var shipSegment = ship_scene.instantiate()
	shipSegment.position = (segment_position * cell_size) + Vector2(0, cell_size)
	add_child(shipSegment)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_place_ships_button_pressed():
	is_place_ships = is_place_ships != true
	print(is_place_ships)
	
