extends Node2D

@export var ship_scene: PackedScene

var cells: int = 10
var cell_size: int = 50

@export var HORIZONTAL_SHIP: Vector2 = Vector2(1,0)
@export var VERTICAL_SHIP: Vector2 = Vector2(0,1)

var is_place_ships: bool = true

var ships: Array = [Vector2(5,5)]

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlaceShipsButton.button_pressed = is_place_ships

func _on_place_ships_button_pressed():
	reverse_is_place_ships()
	if is_place_ships:
		handle_ship_placements()
	else:
		draw_ships()
	
func reverse_is_place_ships():
	is_place_ships = is_place_ships != true

func handle_ship_placements():
	print("handle ship placements")

func draw_ships():
	print("draw ships")
	for ship in ships:
		add_segment(ship)

func add_segment(segment_position: Vector2):
	var shipSegment = ship_scene.instantiate()
	shipSegment.position = (segment_position * cell_size) + Vector2(0, cell_size)
	add_child(shipSegment)
