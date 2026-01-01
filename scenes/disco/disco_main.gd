extends Control

@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer
@onready var left_strip: TextureRect = %LeftStrip
@onready var left_strip_2: TextureRect = %LeftStrip2
@onready var right_strip: TextureRect = %RightStrip
@onready var right_strip_2: TextureRect = %RightStrip2

var step: = 50.0
var movement_tween_1: Tween
var movement_tween_2: Tween
var movement_tween_3: Tween
var movement_tween_4: Tween


func _ready() -> void:
	%ContinueButton.grab_focus()


func _on_button_6_pressed() -> void:
	get_tree().quit()


func _process(_delta: float) -> void:
	pass


func _on_button_focus_entered() -> void:
	audio_stream_player.play()
	if movement_tween_1 and movement_tween_1.is_running():
		movement_tween_1.kill()
	movement_tween_1 = get_tree().create_tween()
	movement_tween_1.parallel().tween_property(left_strip, "position:y", left_strip.position.y - step, 0.3)
	movement_tween_1.parallel().tween_property(left_strip_2, "position:y", left_strip_2.position.y - step, 0.3)
	movement_tween_1.parallel().tween_property(right_strip, "position:y", right_strip.position.y + step, 0.3)
	movement_tween_1.parallel().tween_property(right_strip_2, "position:y", right_strip_2.position.y + step, 0.3)
	
