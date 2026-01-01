@tool
class_name CustomButton extends Control

@export var top_border_line: Color = Color.WHITE:
	set(value):
		top_border_line = value
		queue_redraw()
@export var top_border_line_width: float = 2.0
@export var top_border_line_length: float = 200.0
@export var bottom_border_line: Color = Color.WHITE
@export var bottom_border_line_width: float = 2.0
@export var botom_border_line_length: float = 200.0
@export var left_border_line: Color = Color.WHITE
@export var left_border_line_width: float = 2.0
@export var left_border_line_length: float = 200.0
@export var right_border_line: Color = Color.WHITE
@export var right_border_line_width: float = 2.0
@export var right_border_line_length: float = 200.0
@export var enable_antialiasing: bool = false
@export var start_pos: Vector2 = Vector2.ZERO:
	set(value):
		start_pos = value
		queue_redraw()

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	queue_redraw()


func _draw() -> void:
	var temp_start_pos: = start_pos
	var recrt: Rect2 = Rect2(temp_start_pos, Vector2(top_border_line_length, right_border_line_length))
	if recrt.has_point(get_global_mouse_position()):
		draw_rect(recrt,Color.DARK_BLUE)
	var polyline_pos: PackedVector2Array = [
		temp_start_pos,
		Vector2(temp_start_pos.x + top_border_line_length, temp_start_pos.y),
		Vector2(temp_start_pos.x + top_border_line_length, temp_start_pos.y + right_border_line_length),
		Vector2(temp_start_pos.x, temp_start_pos.y + right_border_line_length),
		temp_start_pos
	]
	draw_polyline(polyline_pos, Color.DARK_RED, 5.0, enable_antialiasing)
	
	
	temp_start_pos = temp_start_pos + Vector2(right_border_line_length + 15, 10.0)
	var multiline_pos: PackedVector2Array = [
		temp_start_pos,
		Vector2(temp_start_pos.x + top_border_line_length, temp_start_pos.y),
		Vector2(temp_start_pos.x + top_border_line_length, temp_start_pos.y -1),
		Vector2(temp_start_pos.x + top_border_line_length - 1, temp_start_pos.y + right_border_line_length),
		Vector2(temp_start_pos.x + top_border_line_length, temp_start_pos.y + right_border_line_length),
		Vector2(temp_start_pos.x, temp_start_pos.y + right_border_line_length),
		Vector2(temp_start_pos.x, temp_start_pos.y + right_border_line_length + 1),
		Vector2(temp_start_pos.x, temp_start_pos.y -1)
	]
	var border_colors_array: PackedColorArray = [
		top_border_line,
		right_border_line,
		bottom_border_line,
		left_border_line
	]
	draw_multiline_colors(multiline_pos, border_colors_array, top_border_line_width, enable_antialiasing)
	
	temp_start_pos = temp_start_pos + Vector2(right_border_line_length + 15, 10.0)
	draw_dashed_line(temp_start_pos, temp_start_pos + Vector2(right_border_line_length + 15, 0.0), Color.RED, 2, 10, true, enable_antialiasing)
