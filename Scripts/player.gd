extends CharacterBody2D


const MAX_SPEED = 100
const FRICTION = 1800
const ACCEL = 600


var face_direction = Vector2.UP

enum States {
	MOVE,
	USING_ITEM
}

var state = States.MOVE


func _ready():
	velocity = Vector2.ZERO


func _physics_process(delta):
	match state:
		States.MOVE:
			move_state(delta)
		States.USING_ITEM:
			using_item_state(delta)
			

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


func using_item_state(delta):
	pass
