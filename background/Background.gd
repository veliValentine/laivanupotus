extends Node2D

var SCREEN_WIDTH = 1280
var SCREEN_HEIGHT = 720

var cells: int = 10
var cell_size: int = 50

func _draw():
	var cubes = cell_size * cells
	var width_margin = (SCREEN_WIDTH / 2 - cubes) / 2
	var height_margin = (SCREEN_HEIGHT - cubes) / 2
	var sea_player = Vector2(width_margin, height_margin)
	var sea_opponent = Vector2(SCREEN_WIDTH - width_margin - cubes, height_margin)
	var size = Vector2(cubes, cubes)
	draw_background()
	draw_sea(sea_player, size)
	draw_sea(sea_opponent, size)
	draw_grid(sea_player, size)
	draw_grid(sea_opponent, size)
	

func draw_background():
	draw_rect(Rect2(0,0,SCREEN_WIDTH, SCREEN_HEIGHT), Color.WHITE)

func draw_sea(position, size):
	draw_rect(Rect2(position, size), Color.DEEP_SKY_BLUE)

func draw_grid(position, size):
	draw_horizontal_lines(position, size)
	draw_vertical_lines(position, size)
	
func draw_horizontal_lines(position, size):
	for i in cells + 1:
		var from = position + Vector2(0, cell_size * i)
		var to_horizontal = from + Vector2(size.x, 0)
		draw_line(from, to_horizontal, Color.BLACK, 3)

func draw_vertical_lines(position, size):
	for i in cells + 1:
		var from = position + Vector2(cell_size * i, 0)
		var to_horizontal = from + Vector2(0,size.y)
		draw_line(from, to_horizontal, Color.BLACK, 3)
