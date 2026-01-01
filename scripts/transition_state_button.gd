extends Button

@export var ease_type: = Tween.EASE_OUT
@export var trans_type: = Tween.TRANS_CUBIC

var tween_stylebox:StyleBoxFlat
var styleboxes:Dictionary = {}
var current_state = BaseButton.DRAW_NORMAL

var tween: Tween


func _ready() -> void:
# Duplicate the normal stylebox. We are going to use it as our base stylebox
	tween_stylebox = get_theme_stylebox('normal').duplicate()
	# Save the different styleboxes to be able to tween between their properties later
	styleboxes[BaseButton.DRAW_NORMAL] = get_theme_stylebox('normal').duplicate()
	styleboxes[BaseButton.DRAW_HOVER] = get_theme_stylebox('hover').duplicate()
	styleboxes[BaseButton.DRAW_PRESSED] = get_theme_stylebox('pressed').duplicate()
	styleboxes[BaseButton.DRAW_HOVER_PRESSED] = get_theme_stylebox('pressed').duplicate()
	# Override all the other styleboxes with our tween stylebox
	add_theme_stylebox_override('normal', tween_stylebox)
	add_theme_stylebox_override('hover', tween_stylebox)
	add_theme_stylebox_override('pressed', tween_stylebox)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if get_draw_mode() != current_state:
		# If the draw mode changed
		current_state = get_draw_mode()
		# Kill the running tween
		if tween and tween.is_running():
			tween.kill()
		# And create a new one
		tween = create_tween().set_ease(ease_type).set_trans(trans_type).set_parallel()
		# That tweens some properties of our tween stylebox to the target stylebox
		# depending on the current state
		var target = styleboxes[current_state] as StyleBoxFlat
		tween.tween_property(tween_stylebox, "bg_color", target.bg_color, 0.2)
		tween.tween_property(tween_stylebox, "shadow_size", target.shadow_size, 0.2)
		tween.tween_property(tween_stylebox, "shadow_color", target.shadow_color, 0.2)
		tween.tween_property(tween_stylebox, "shadow_offset", target.shadow_offset, 0.2)
		tween.tween_property(tween_stylebox, "border_color", target.border_color, 0.2)
		tween.tween_property(tween_stylebox, "corner_radius_top_left", target.corner_radius_top_left, 0.2)
		tween.tween_property(tween_stylebox, "corner_radius_top_right", target.corner_radius_top_right, 0.2)
		tween.tween_property(tween_stylebox, "corner_radius_bottom_left", target.corner_radius_bottom_left, 0.2)
		tween.tween_property(tween_stylebox, "corner_radius_bottom_right", target.corner_radius_bottom_right, 0.2)
