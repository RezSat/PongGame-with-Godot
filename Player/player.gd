extends KinematicBody2D

var speed = 400
const GAME_SIZE = Vector2(1280, 720)
	
func _physics_process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_touch"):
		var input_position = get_global_mouse_position()
		if position.y < input_position.y:
			velocity.y += min(1.5 * speed, (input_position.y - position.y) / delta)
		elif position.y > input_position.y:
			velocity.y -= min(1.5 * speed, (position.y - input_position.y) / delta)
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1 * speed
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1 * speed
	move_and_slide(velocity)
