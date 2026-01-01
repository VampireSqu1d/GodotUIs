extends HBoxContainer

enum TYPES {close, maximize, minimize}
@export var types: TYPES = TYPES.close
@export var icon: CompressedTexture2D = preload("res://icons/x.svg")

func _ready():
	$systemButton/icon.texture = icon
	
