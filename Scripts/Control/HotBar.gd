extends Control


@onready var hotbarContainer = $HotbarContainer



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func update_hotbar(inventory:Dictionary):
	hotbarContainer.update_hotbarPanels(inventory)
