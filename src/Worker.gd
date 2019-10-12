extends KinematicBody2D

const Speed = 100

var is_moving = false
var step_delay = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	is_moving = false
	var delta_pos = Vector2()
	if Input.is_action_pressed("move_right"):
		delta_pos.x += Speed
		is_moving = true
	
	elif Input.is_action_pressed("move_left"):
		delta_pos.x -= Speed
		is_moving = true

	if Input.is_action_pressed("move_up"):
		delta_pos.y -= Speed
		is_moving = true
	elif Input.is_action_pressed("move_down"):
		delta_pos.y += Speed
		is_moving = true
	
	move_and_slide(delta_pos)
	#updateAnimation()
	
	step_delay -= delta
	if is_moving:
		if step_delay <= 0:
			step_delay = 0.12
			#var snd = step_sounds[(0 if step_sound_one_is_next else 1)]
			#step_sound_one_is_next = not step_sound_one_is_next
			#snd.play()