extends Node2D

var SCREEN_WIDTH = 1280
var SCREEN_HEIGHT = 720

var cells: int = 10
var cell_size: int = 50

var sea_size = cell_size * cells
var sea_area = Vector2(sea_size, sea_size)
var width_margin = (SCREEN_WIDTH / 2 - sea_size) / 2
var height_margin = (SCREEN_HEIGHT - sea_size) / 2

@export var PLAYER_SEA_POSITION = Vector2(width_margin, height_margin)
@export var OPPONENT_SEA_POSITION = Vector2(SCREEN_WIDTH - width_margin - sea_size, height_margin)

func _draw():
	draw_background()
	draw_sea(PLAYER_SEA_POSITION)
	draw_sea(OPPONENT_SEA_POSITION)
	draw_grid(PLAYER_SEA_POSITION)
	draw_grid(OPPONENT_SEA_POSITION)
	draw_axis_labels(PLAYER_SEA_POSITION)
	draw_axis_labels(OPPONENT_SEA_POSITION)
	draw_title(PLAYER_SEA_POSITION, "ALLY SHIPS")
	draw_title(OPPONENT_SEA_POSITION, "OPPONENT")
	

func draw_background():
	draw_rect(Rect2(0,0,SCREEN_WIDTH, SCREEN_HEIGHT), Color.WHITE)

func draw_sea(sea_position):
	draw_rect(Rect2(sea_position, sea_area), Color.DEEP_SKY_BLUE)

func draw_grid(sea_position):
	draw_horizontal_lines(sea_position)
	draw_vertical_lines(sea_position)
	
func draw_horizontal_lines(sea_position):
	for i in cells + 1:
		var from = sea_position + Vector2(0, cell_size * i) + Vector2(-cell_size / 2,0)
		var to_horizontal = from + Vector2(sea_size + 1 * cell_size, 0)
		draw_line(from, to_horizontal, Color.BLACK, 3)

func draw_vertical_lines(sea_position):
	for i in cells + 1:
		var from = sea_position + Vector2(cell_size * i, 0) + Vector2(0, -cell_size / 2)
		var to_horizontal = from + Vector2(0,sea_size + 1 * cell_size)
		draw_line(from, to_horizontal, Color.BLACK, 3)

func draw_axis_labels(sea_position):
	draw_alphabets(sea_position)
	draw_alphabets(sea_position + Vector2(0, sea_size + cell_size))
	draw_numbers(sea_position)
	draw_numbers(sea_position + Vector2(sea_size + cell_size, 0))

func draw_alphabets(start_position):
	var alphabets: Array = "ABCDEFGHIKLMNOPQRSTU".rsplit()
	for index in range(cells):
		var label = get_label_base()
		label.text = alphabets[index]
		var horizontal_offset = Vector2(cell_size / 4, 0)
		var vertical_offset = Vector2(0, -50)
		label.set_position(start_position + Vector2(cell_size,0) * index + horizontal_offset + vertical_offset)
		add_child(label)

func draw_numbers(start_position):
	for index in range(cells):
		var label = get_label_base()
		label.text = str(index + 1)
		var horizontal_offset = Vector2(-cell_size + cell_size / 10, 0)
		label.set_position(start_position + Vector2(0,cell_size) * index + horizontal_offset)
		add_child(label)

func get_label_base():
	var label = Label.new()
	label.add_theme_color_override("font_color", Color.BLACK)
	label.add_theme_font_size_override("font_size", 34)
	return label

func draw_title(start_position, text):
	var label = Label.new()
	label.add_theme_color_override("font_color", Color.BLACK)
	label.add_theme_font_size_override("font_size", 50)
	label.text = text
	var position_offset = Vector2(cell_size * 2, -cell_size * 2.2)
	label.set_position(start_position + position_offset)
	add_child(label)
