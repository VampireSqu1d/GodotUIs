@tool
extends ColorRect

enum TYPES {close, maximize, minimize}
@export var types: TYPES = TYPES.close
@export var icon: CompressedTexture2D = preload("res://icons/x.svg"):
	set(value):
		icon = value
		$icon.texture = icon
@export var col = Color("13093d")  # (Color, RGB)
@export var colentered  = Color("13093d")# (Color, RGB)

func _ready():
	$icon.texture = icon


func _process(_delta: float) -> void:
	if Engine.is_editor_hint(): return


func _on_systemButton_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.get_button_index() == 1:
			if types == TYPES.close:
				get_tree().quit()
			elif types == TYPES.minimize:
				get_window().mode = Window.MODE_MINIMIZED if (true) else Window.MODE_WINDOWED
			elif types == TYPES.maximize:
				get_window().mode = Window.MODE_MAXIMIZED if (!(get_window().mode == Window.MODE_MAXIMIZED)) else Window.MODE_WINDOWED


func _on_systemButton_mouse_entered():
	if types == TYPES.close:
		$".".color = "e11f1f"# color red for close button
	else:
		$".".color = colentered


func _on_systemButton_mouse_exited():
	$".".color = col
