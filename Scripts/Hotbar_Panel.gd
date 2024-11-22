class_name Hotbar_Panel
extends Panel


@onready var sprite = $Sprite2D
@onready var selectRect = $SelectRect


const MAX_SIZE = 32

# Called when the node enters the scene tree for the first time.
func _ready():
	set_selected(false)


func set_selected(is_selected:bool):
	if is_selected:
		selectRect.visible = true
	else:
		selectRect.visible = false


func change_sprite_texture(texture:Texture):
	sprite.set_texture(texture)
	
	if texture == null:
		return
	
	change_scale(texture)


func change_scale(texture:Texture):
#	change scale
	
#	find the min of width and height
	var width = texture.get_width()
	var height = texture.get_height()
	var min_side = max(width, height)
	
#	find the scale_ratio
	var scale_ratio = float(MAX_SIZE) / float(min_side)
	
#	multiply the sprite scale by min_side to max_size ratio
	var new_scale = Vector2(scale_ratio, scale_ratio)
	sprite.set_scale(new_scale)
	
	pass
