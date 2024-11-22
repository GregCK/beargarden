class_name HeldSeed
extends Item


var plant_type:PlantType
func get_item_name() -> String:
	return plant_type.plant_name + " seed"
