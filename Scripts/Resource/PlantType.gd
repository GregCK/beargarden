class_name PlantType
extends Resource

const SEED_SPRITE = preload("res://Resources/Assets/Images/seed0.png")

enum Height{
	GROUND, #moss
	SHORT, #lettuce
	MEDIUM, #bush
	TALL, #corn
	TOWERING #tree 
}

@export var plant_name:String = "Plant Name"
@export var drinking_period:int = 3
@export var progress_to_mature:int = 10
@export var progress_to_sprite:Dictionary = {
	0 : SEED_SPRITE
}
@export var progress_to_height:Dictionary = {
	0.0 : Height.GROUND
}
@export var tilemap_source_id:int = -1
@export var prefered_sunlight_status:int = PlantData.SunLightStatus.PARTIAL_SUN
