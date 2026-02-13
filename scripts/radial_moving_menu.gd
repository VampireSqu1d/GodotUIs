extends Control

@export var radius: float = 120.0
@export var animation_duration: float = 0.3
@export var animation_transition: Tween.TransitionType
@export var animation_ease: Tween.EaseType
@export var buttons: Array[Button] = []

@onready var reference_point: Control = %ReferencePoint

var tween: Tween

func _ready() -> void:
	get_tree().create_timer(0.2)
	#show_buttons()


func show_buttons() -> void:
	var spacing: = PI / buttons.size() 
	
	var counter: int = 0
	for button in buttons:
		var angle: = spacing * counter - (TAU)
		var tagetDirection: = Vector2(0, radius).rotated(angle)
		var targetPostion: = reference_point.global_position - (button.size/2) - tagetDirection 
		counter+=1
		var tween: = get_tree().create_tween()
		tween.tween_property(button, "global_position", targetPostion, animation_duration)


func hide_buttons() -> void:
	for button in buttons:
		var tween: = get_tree().create_tween()
		tween.tween_property(button, "global_position", reference_point.global_position - button.size, animation_duration)


func _on_strikethrought_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		show_buttons()
	else:
		hide_buttons()
