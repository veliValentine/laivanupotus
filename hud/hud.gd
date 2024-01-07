extends CanvasLayer

signal toggle_place_ships
signal marked_changed
signal new_game_started

@export var is_place_ships: bool = true

@export var selected_marker_id = -1

func _ready():
	place_children_positions()
	
	$PlaceShipsButton.button_pressed = is_place_ships
	$MarkerSelector.set_disabled(is_place_ships)
	$NewGameDialog.visible = false

func place_children_positions():
	$PlaceShipsButton.position = Vector2(0, 660)
	$MarkerSelector.position = Vector2(Settings.SCREEN_WIDTH / 2 - 75, 660)
	$NewGameButton.position = Vector2(Settings.SCREEN_WIDTH - 200, 660)
	$NewGameDialog.set_position(Vector2(Settings.SCREEN_WIDTH / 2 - 150, 330 - 75))

func _on_place_ships_button_pressed():
	is_place_ships = !is_place_ships
	$MarkerSelector.set_disabled(is_place_ships)
	toggle_place_ships.emit()

func _on_selector_item_selected(index):
	selected_marker_id = $MarkerSelector.get_item_id(index)
	marked_changed.emit()


func _on_new_game_button_pressed():
	$NewGameDialog.visible = true


func _on_new_game_dialog_confirmed():
	$NewGameDialog.visible = false
	new_game_started.emit()


func _on_new_game_dialog_canceled():
	$NewGameDialog.visible = false
