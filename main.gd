extends Node2D

@export var ship_scene: PackedScene

var ships: Array

func _ready():
	print($Background.PLAYER_SEA_POSITION)

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
	shipSegment.position = (segment_position * Settings.CELL_SIZE) + Vector2(0, Settings.CELL_SIZE)
	add_child(shipSegment)
