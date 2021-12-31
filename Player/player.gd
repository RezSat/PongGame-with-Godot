extends KinematicBody2D

var speed = 400
const NORMAL_POSITION = Vector2(100, 300)
const GAME_SIZE = Vector2(1280, 720)
var PADDLE_SIZE = Vector2(1,1.5)
	
func _physics_process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_touch"):
		var input_position = get_global_mouse_position()
		if velocity.y < 0 and input_position.y <= PADDLE_SIZE.y:
			velocity.y = 0
		if velocity.y > 0 and input_position.y >= GAME_SIZE.y - PADDLE_SIZE.y:
			velocity.y = 0
		if NORMAL_POSITION.y < input_position.y:
			velocity.y += 1.5
		elif NORMAL_POSITION.y > input_position.y:
			velocity.y -= 1.5
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	move_and_slide(velocity * speed)
