extends Control

@onready var left_v_box_container: VBoxContainer = %LeftVBoxContainer
@onready var new_game_button: Button = %NewGameButton
@onready var continue_button: Button = %ContinueButton
@onready var options_button: Button = %OptionsButton
@onready var save_button: Button = %SaveButton
@onready var quit_button: Button = %QuitButton
@onready var right_v_box_container_2: VBoxContainer = %RightVBoxContainer2


func _ready() -> void:
	new_game_button.grab_focus()


func _on_quit_button_pressed() -> void:
	get_tree().quit(0)
