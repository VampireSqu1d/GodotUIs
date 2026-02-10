extends Control
class_name MovingButtonsUI

@export var anim_transition: Tween.TransitionType
@export var anim_ease: Tween.EaseType
@export var anim_duration: float = 0.3
@export var buttons_separation: int = 40
@export var buttons: Array[Button] = [] 

@onready var reference_point: Control = %ReferencePoint

 
func _ready() -> void:
	setup_buttons()
	await get_tree().create_timer(0.3).timeout
	present_buttons()


func setup_buttons() -> void:
	var counter: int = 0
	for button: Button in buttons:
		var vector: = Vector2(reference_point.position.x - button.size.x, reference_point.position.y + (buttons_separation * counter))
		button.position = vector
		counter +=1


func present_buttons() -> void:
	for button: Button in buttons:
		var tween: = get_tree().create_tween().set_ease(anim_ease).set_trans(anim_transition)
		
		tween.tween_property(button, "position:x", reference_point.position.x + 100, anim_duration)
		
		await get_tree().create_timer(0.1).timeout


func _on_texture_button_pressed() -> void:
	setup_buttons()
	await get_tree().create_timer(0.3).timeout
	present_buttons()
