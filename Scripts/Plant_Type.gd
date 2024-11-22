class_name Plant_Type
extends Resource

const SEED_SPRITE = preload("res://Resources/Assets/Images/seed0.png")


@export var plant_name:String = "Plant Name"
@export var drinking_period:int = 3
@export var progress_to_mature:int = 10
@export var progress_to_sprite:Dictionary = {
	0 : SEED_SPRITE
}
@export var tilemap_source_id:int = -1
