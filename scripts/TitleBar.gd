extends Control


var following = false
var start_pos = Vector2()


func _on_TitleBar_gui_input(event):
	if event is InputEventMouseButton and event.get_button_index() == 1:
		following = !following
		start_pos = get_local_mouse_position()
	if following:
		get_window().set_position(Vector2(get_window().position) + get_local_mouse_position() - start_pos)
