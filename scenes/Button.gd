extends Button

@onready var animplayer = $"../../../../../AnimationPlayer"


func _on_Button_gui_input(event):
	if event is InputEventMouseButton and event.get_button_index() == 1 and event.is_pressed():
		if $"../../..".custom_minimum_size[0] == 70:
			animplayer.play("New Anim")
		else:
			animplayer.play_backwards("New Anim")
