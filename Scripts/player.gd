class_name Player
extends CharacterBody2D

const HELD_SEED = preload("res://Scenes/held_seed.tscn")

@onready var hotbar = $CanvasLayer/HotBar
@onready var selectedItemNameLabel = $CanvasLayer/HotBar/SelectedItemNameLabel

var face_direction:Vector2i = Vector2.UP
var state = States.MOVE


var inventory = {}
var inventory_selected_index:int = 0

const MAX_SPEED = 100
const FRICTION = 1800
const ACCEL = 600


enum States {
	MOVE,
	WATER,
	PLANT
}

signal enter_water_state
signal enter_plant_state


func _ready():
	#	instance the inventory
#	1 - range
	for i in range(10):
		inventory[i] = null
	
	inventory[0] = HELD_SEED.instantiate()
	inventory[0].plant_type = load("res://Resources/Plant_Types/tomato.tres")
	inventory[1] = HELD_SEED.instantiate()
	inventory[1].plant_type = load("res://Resources/Plant_Types/basil.tres")
	pass
	
	#	update the hotbar
	hotbar.update_hotbar(inventory)
	
	update_selected_item_name_label(inventory_selected_index)


func _physics_process(delta):
	match state:
		States.MOVE:
			move_state(delta)
		States.WATER:
			water_state(delta)
		States.PLANT:
			plant_state(delta)

func move_state(delta):
	#	handle movement
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	input_vector = input_vector.normalized()
	
	
	
	if input_vector != Vector2.ZERO:
		face_direction = input_vector
		
#		set_flip(input_vector)
		
#		animationPlayer.play("Run")
		
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCEL * delta)
	else:
#		animationPlayer.play("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("water"):
		switch_state(States.WATER)
	elif Input.is_action_just_pressed("use_item"):
		switch_state(States.PLANT)

func water_state(delta):
	pass

func plant_state(delta):
	pass

func switch_state(new_state:States):
	match new_state:
		States.MOVE:
			pass
		States.WATER:
			emit_signal("enter_water_state")
		States.PLANT:
			emit_signal("enter_plant_state")
		
	state = new_state


func _on_hotbar_container_hotbar_panel_selected(index):
	update_selected_item_name_label(index)

func update_selected_item_name_label(index):
	if not inventory.has(index):
		return
	var item = inventory[index]
	if item == null:
		selectedItemNameLabel.set_text("Empty")
		return
	var item_name:String = item.get_item_name()
	selectedItemNameLabel.set_text(item_name)
