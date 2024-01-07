extends Node

var SCREEN_WIDTH: int = 1280
var SCREEN_HEIGHT: int = 720

var CELLS: int = 10
var CELL_SIZE: int = 50

func _ready():
	var screen_size = get_viewport().size
	SCREEN_WIDTH = screen_size.x
	SCREEN_HEIGHT = screen_size.y
