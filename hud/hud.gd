extends CanvasLayer

signal toggle_place_ships

@export var is_place_ships: bool = true

func _ready():
	$PlaceShipsButton.button_pressed = is_place_ships

func _on_place_ships_button_pressed():
	is_place_ships = !is_place_ships
	toggle_place_ships.emit()
