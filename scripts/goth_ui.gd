extends Control

@onready var select_arrows: TextureRect = %SelectArrows
@onready var play_button: TextureButton = %PlayButton
@onready var load_button: TextureButton = %LoadButton
@onready var options_button: TextureButton = %OptionsButton
@onready var quit_button: TextureButton = %QuitButton

@export var selected_button: BaseButton = null:
	set(value):
		if is_inside_tree():
			selected_button = value
			
			selected_button.grab_focus()
			move_arrows()
@export var buttons_array: Array[TextureButton] = []

@export var anim_duration: float = 0.2
@export var anim_ease: Tween.EaseType = Tween.EASE_IN
@export var anim_trans: Tween.TransitionType = Tween.TRANS_LINEAR

func _ready() -> void:
	buttons_array.append(play_button)
	buttons_array.append(load_button)
	buttons_array.append(options_button)
	buttons_array.append(quit_button)
	
	
	for i: TextureButton in buttons_array:
		i.focus_entered.connect(_on_button_focus_entered.bind(i))
		
	if selected_button == null and buttons_array.size() > 0:
		selected_button = buttons_array[0]


func _on_texture_button_3_pressed() -> void:
	get_tree().quit(0)


var _tween: Tween = null
func move_arrows() -> void:
	if _tween and _tween.is_running():
		_tween.kill()
	
	_tween = create_tween().set_ease(anim_ease).set_trans(anim_trans)
	
	_tween.tween_property(select_arrows, "global_position:y", selected_button.global_position.y, anim_duration)
	


func _on_button_focus_entered(button: BaseButton) -> void:
	selected_button = button
	move_arrows()
