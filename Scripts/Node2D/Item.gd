class_name Item
extends Node

signal item_pressed
signal item_released

@export var item_name:String : get = get_item_name
func get_item_name():
	return item_name


@export var hotbarTexture:Texture:
	get:
		return hotbarTexture
	set(new_texture):
		hotbarTexture = new_texture


func _input(event):
	if event.is_action_pressed("use_item"):
		emit_signal("item_pressed")
	if event.is_action_released("use_item"):
		emit_signal("item_released")
