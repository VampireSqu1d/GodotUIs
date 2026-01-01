extends Control

@export var menu_transition_duration: float = 0.8

@onready var menu_1: MarginContainer = %Menu1
@onready var menu_2: MarginContainer = %Menu2


var current_menu: Control
var menu_stack: Array[Control] = []
var menu_origin_position: = Vector2.ZERO
var menu_origin_size: = Vector2.ZERO
var tween: Tween

func _ready() -> void:
	menu_origin_position = Vector2.ZERO
	menu_origin_size = get_viewport_rect().size
	current_menu = menu_1


func move_to_next_menu(next_menu_id: String) -> void:
	var next_menu: = get_menu_from_id(next_menu_id)
	if tween and tween.is_running():
		await tween.finished
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING).set_parallel()
	tween.tween_property(current_menu, "global_position",  Vector2(-menu_origin_size.x, 0), menu_transition_duration)
	tween.tween_property(next_menu, "global_position", menu_origin_position, menu_transition_duration)
	menu_stack.append(current_menu)
	current_menu = next_menu


func move_to_previous_menu() -> void:
	var previous_menu: Control = menu_stack.pop_back()
	if previous_menu != null:
		if tween and tween.is_running():
			await tween.finished
			tween.kill()
		tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING).set_parallel()
		tween.tween_property(previous_menu, "global_position",  menu_origin_position, menu_transition_duration)
		tween.tween_property(current_menu, "global_position", Vector2(menu_origin_size.x, 0), menu_transition_duration)
		current_menu = previous_menu



func get_menu_from_id(menu_id: String) -> Control:
	match menu_id:
		"Menu1":
			return menu_1
		"Menu2":
			return menu_2
		_:
			return menu_1


func _on_button_4_pressed() -> void:
	get_tree().quit()


func _on_back_button_menu_2_pressed() -> void:
	move_to_previous_menu()


func _on_options_button_menu_1_pressed() -> void:
	move_to_next_menu("Menu2")
