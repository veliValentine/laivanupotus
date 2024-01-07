extends Node2D

@export var ship_scene: PackedScene
@export var hit_scene: PackedScene
@export var miss_scene: PackedScene

func _ready():	
	$Ships.is_place_ships_enabled = $Hud.is_place_ships
	$Ships.SEA_POSITION = $Background.PLAYER_SEA_POSITION
	$PlayerMarkers.is_place_markers_enabled = !$Hud.is_place_ships
	$PlayerMarkers.SEA_POSITION = $Background.PLAYER_SEA_POSITION
	$OpponentMarkers.is_place_markers_enabled = !$Hud.is_place_ships
	$OpponentMarkers.SEA_POSITION = $Background.OPPONENT_SEA_POSITION


func _on_hud_toggle_place_ships():
	$Ships.is_place_ships_enabled = $Hud.is_place_ships
	$PlayerMarkers.is_place_markers_enabled = !$Hud.is_place_ships
	$OpponentMarkers.is_place_markers_enabled = !$Hud.is_place_ships

func _on_ships_ship_placed():
	draw_ships()

func draw_ships():
	clear_ship_segments()
	var ship_storage = $Ships.get_ships()
	for ships_x in ship_storage:
		for ships_y in ship_storage[ships_x]:
			var ship_position = Vector2(ships_x, ships_y)
			add_ship_segment(ship_position)

func clear_ship_segments():
	get_tree().call_group("ship_segments", "queue_free")

func add_ship_segment(segment_position: Vector2):
	var shipSegment = ship_scene.instantiate()
	shipSegment.position = $Background.PLAYER_SEA_POSITION + (segment_position * Settings.CELL_SIZE)
	add_child(shipSegment)


func _on_player_markers_marker_placed():
	update_markers()

func _on_opponent_markers_marker_placed():
	update_markers()

func update_markers():
	clear_markers()
	var player_markers = $PlayerMarkers.get_storage().get_all_as_vectors()
	handle_markers(player_markers, $Background.PLAYER_SEA_POSITION)
	var opponent_markers = $OpponentMarkers.get_storage().get_all_as_vectors()
	handle_markers(opponent_markers, $Background.OPPONENT_SEA_POSITION)

func clear_markers():
		get_tree().call_group("markers", "queue_free")

func handle_markers(markers, offset: Vector2):
	for marker in markers:
		var position = Vector2(marker.x, marker.y)
		var marker_type = marker.z
		if  $PlayerMarkers.is_hit_marker(marker_type):
			draw_marker(hit_scene.instantiate(), position, offset)
		if $PlayerMarkers.is_miss_marker(marker_type):
			draw_marker(miss_scene.instantiate(), position, offset)

func draw_marker(scene: Node, position: Vector2, offset_position: Vector2):
	scene.position = offset_position + ((position + Vector2(0.25, 0.25)) * Settings.CELL_SIZE)
	add_child(scene)
