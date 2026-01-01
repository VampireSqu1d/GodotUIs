extends Control

@export var icon: CompressedTexture2D
@export var label = "Home"
@export var active = false
@export var page: NodePath

func _ready():
	$Icon.texture = icon
	$Label.text = label
	update_elements()

func set_active():
	active = true
	update_elements()

func deactive():
	active = false
	update_elements()

func update_elements():
	$active.visible = active
	get_node(page).visible = active


func _on_navItem_mouse_entered():
	$bg.color = "bf1564"


func _on_navItem_mouse_exited():
	$bg.color = "0b042a"


func _on_navItem_gui_input(event):
	if event is InputEventMouseButton and event.get_button_index() == 1 and event.is_pressed():
		var navitems = get_tree().get_nodes_in_group("navItem")
		for item in navitems:
			item.deactive()
		set_active()
