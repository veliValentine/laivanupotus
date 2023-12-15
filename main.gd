extends Node2D

@export var ship_scene: PackedScene

var SCREEN_WIDTH = 1280
var SCREEN_HEIGHT = 720

var cells: int = 10
var cell_size: int = 50

@export var HORIZONTAL_SHIP: Vector2 = Vector2(1,0)
@export var VERTICAL_SHIP: Vector2 = Vector2(0,1)

var ships: Array = [Vector2(5,5)]


func _on_hud_toggle_place_ships():
	if $Hud.is_place_ships:
		handle_ship_placements()
	else:
		draw_ships()

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
