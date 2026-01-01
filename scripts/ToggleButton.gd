extends Control

@onready var animplayer = $"../../../../../AnimationPlayer"



func _on_ToggleButton_gui_input(event):
	if event is InputEventMouseButton and event.get_button_index() == 1 and event.is_pressed():
		if $"../../..".custom_minimum_size[0] == 70:
			animplayer.play("sidebar_anim")
		else:
			animplayer.play_backwards("sidebar_anim")
