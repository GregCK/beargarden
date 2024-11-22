class_name Player
extends CharacterBody2D


var face_direction:Vector2i = Vector2.UP
var state = States.MOVE

const MAX_SPEED = 100
const FRICTION = 1800
const ACCEL = 600




enum States {
	MOVE,
	WATER
}

signal enter_water_state


func _ready():
	velocity = Vector2.ZERO


func _physics_process(delta):
	match state:
		States.MOVE:
			move_state(delta)
		States.WATER:
			water_state(delta)
			

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

func water_state(delta):
	pass

func switch_state(new_state:States):
	match new_state:
		States.MOVE:
			pass
		States.WATER:
			emit_signal("enter_water_state")
		
	state = new_state
