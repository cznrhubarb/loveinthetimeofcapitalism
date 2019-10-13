extends KinematicBody2D

const Speed = 300

onready var anim_player = get_node("AnimationPlayer")
onready var spr = get_node("Sprite")
onready var inventory = get_tree().get_root().find_node("Inventory", true, false)

var is_moving = false
var step_sounds
var step_sound_one_is_next = true
var step_delay = 0
var pick_up_time = 1.5
var inventory_delay = pick_up_time
var touching_bin = null

# Called when the node enters the scene tree for the first time.
func _ready():
	step_sounds = [ get_node("StepOne"), get_node("StepTwo") ]

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
	
	step_delay -= delta
	if is_moving:
		anim_player.play("Walk")
		spr.rotation = atan2(delta_pos.y, delta_pos.x) + 3.14159/2
		if step_delay <= 0:
			step_delay = 0.2
			var snd = step_sounds[(0 if step_sound_one_is_next else 1)]
			step_sound_one_is_next = not step_sound_one_is_next
			snd.play()
	else:
		anim_player.play("Idle")
	
	if touching_bin != null and Input.is_action_pressed("pick_up"):
		inventory_delay -= delta
		if inventory_delay <= 0:
			# You only get one for each time you hold it down
			inventory_delay = 1000
			inventory.add_item(touching_bin.item_type)
	else:
		inventory_delay = pick_up_time