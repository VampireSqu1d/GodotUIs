@tool
class_name StrikethroughtButton
extends CheckBox

@export var label_text: = "Place Holder Text":
	set(value):
		label_text = value
		if self:
			text = label_text

@export var strike_color: Color = Color.BLACK:
	set(value):
		strike_color = value
		if progress_bar:
			var new_stylebox: = StyleBoxFlat.new()
			new_stylebox.bg_color = strike_color
			progress_bar.add_theme_stylebox_override("fill", new_stylebox)

@export var fill_mode: ProgressBar.FillMode = ProgressBar.FillMode.FILL_BEGIN_TO_END:
	set(value):
		fill_mode = value
		if progress_bar:
			progress_bar.fill_mode = fill_mode

@export var animation_transition: = Tween.TransitionType.TRANS_LINEAR
@export var animation_ease: = Tween.EaseType.EASE_IN
@export var animation_duration: float = 0.3
@export var top_margin: int = 20
@export var bottom_margin: int = 20

@onready var margin_container: MarginContainer = %MarginContainer
@onready var progress_bar: ProgressBar = %ProgressBar

func _ready() -> void:
	var new_stylebox: = StyleBoxFlat.new()
	new_stylebox.bg_color = strike_color
	progress_bar.add_theme_stylebox_override("fill", new_stylebox)
	progress_bar.fill_mode = fill_mode
	text = label_text


var strike_tween: Tween
func strike_throught_text(strike: bool = true) -> void:
	if strike_tween and strike_tween.is_running():
		strike_tween.kill()
	
	strike_tween = get_tree().create_tween().set_ease(animation_ease).set_trans(animation_transition)
	strike_tween.tween_property(progress_bar, "value", 100.0 if strike else 0.0, animation_duration)


func _on_toggled(toggled_on: bool) -> void:
	strike_throught_text(toggled_on)
