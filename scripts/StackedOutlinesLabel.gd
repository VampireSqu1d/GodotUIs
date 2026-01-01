@tool
class_name OutlineFxLabel
extends Label

@export var text_color: Color = Color.WHITE
@export var outline1_color: Color = Color.WHITE
@export var outoline1_size: = 8
@export var outline2_color: Color = Color.WHITE
@export var outoline2_size: = 10
@export var outline3_color: Color = Color.WHITE
@export var outline3_size: = 12


func _ready() -> void:
	
	for i: int in label_settings.stacked_outline_count:
		_increment_outline(i)
		
		#var timer: Timer = Timer.new()
		#timer.timeout.connect(_on_timer_timeout)
		#timer.one_shot = false
		#
		#add_child(timer)
		#timer.start()

func _increment_outline(index: int) -> void:
	var tween: = get_tree().create_tween()
	tween.tween_property(label_settings, "outline_size:%d" % index, 34, 1)
	
	tween.finished.connect(_decrement_outline.bind(index))
	#label_settings.get_stacked_outline_size(index)

func _decrement_outline(index: int) -> void:
	var tween: = get_tree().create_tween()
	var outline: = "stacked_outline_"+ str(index) +":size" 
	
	#tween.tween_property(label_settings, , 0, 1)
	
	tween.finished.connect(_increment_outline.bind(index))
	


func _on_timer_timeout() -> void:
	if label_settings.get_stacked_outline_size(5) >= 34:
		
		label_settings.set_stacked_outline_size(5, 0)
		label_settings.move_stacked_outline(5, 0)
		label_settings.set_stacked_outline_size(3, label_settings.get_stacked_outline_size(3) * 0.5)
		label_settings.set_stacked_outline_size(4, label_settings.get_stacked_outline_size(4) * 0.5)
		label_settings.set_stacked_outline_size(5, label_settings.get_stacked_outline_size(5) * 0.5)
		
	label_settings.set_stacked_outline_size(0, label_settings.get_stacked_outline_size(0) + 1)
	label_settings.set_stacked_outline_size(1, label_settings.get_stacked_outline_size(1) + 1)
	label_settings.set_stacked_outline_size(2, label_settings.get_stacked_outline_size(2) + 1)
	label_settings.set_stacked_outline_size(3, label_settings.get_stacked_outline_size(3) + 1)
	label_settings.set_stacked_outline_size(4, label_settings.get_stacked_outline_size(4) + 1)
	label_settings.set_stacked_outline_size(5, label_settings.get_stacked_outline_size(5) + 1)
	
	
	#await get_tree().create_timer(0.3).timeout
	
