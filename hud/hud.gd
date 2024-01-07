extends CanvasLayer

signal toggle_place_ships
signal marked_changed

@export var is_place_ships: bool = true

@export var selected_marker_id = -1

func _ready():
	$PlaceShipsButton.button_pressed = is_place_ships

func _on_place_ships_button_pressed():
	is_place_ships = !is_place_ships
	toggle_place_ships.emit()

func _on_selector_item_selected(index):
	selected_marker_id = $MarkerSelector.get_item_id(index)
	marked_changed.emit()
