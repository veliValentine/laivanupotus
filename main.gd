extends Node2D

@export var ship_scene: PackedScene

func _ready():
	$Ships.is_place_ships_enabled = $Hud.is_place_ships
	$Ships.SEA_POSITION = $Background.PLAYER_SEA_POSITION

func _on_hud_toggle_place_ships():
	$Ships.is_place_ships_enabled = $Hud.is_place_ships

func _on_ships_ship_placed():
	draw_ships()

func draw_ships():
	clear_ship_segments()
	var ships = $Ships.get_ships()
	for ships_x in ships:
		for ships_y in ships[ships_x]:
			var ship_position = Vector2(ships_x, ships_y)
			add_segment(ship_position)

func clear_ship_segments():
	get_tree().call_group("ship_segments", "queue_free")

func add_segment(segment_position: Vector2):
	var shipSegment = ship_scene.instantiate()
	shipSegment.position = $Background.PLAYER_SEA_POSITION + (segment_position * Settings.CELL_SIZE)
	add_child(shipSegment)
