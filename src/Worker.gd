extends KinematicBody2D

const Speed = 300

onready var anim_player = get_node("AnimationPlayer")
onready var spr = get_node("Sprite")
onready var inventory = get_tree().get_root().find_node("Inventory", true, false)
onready var orders = get_tree().get_root().find_node("Slidedown Menu", true, false)
onready var pickup_percentage = get_tree().get_root().find_node("PickupPercentage", true, false)

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

		# Show progress as player holds pick_up key
		pickup_percentage.text = pickup_percentage_text_formatter(pick_up_time, inventory_delay)

		if inventory_delay <= 0:
			# You only get one for each time you hold it down
			inventory_delay = 1000
			if do_i_need_this(touching_bin.item_type):
				inventory.add_item(touching_bin.item_type)
			else:
				get_node("Huh").play()
	else:
		# Reset progress if player stops touching bin,
		# or if player stops pressing pick_up key
		pickup_percentage.text = ""
		inventory_delay = pick_up_time

func do_i_need_this(item):
	for order in orders.line_items:
		if order.type == item:
			return true
	return false

# These animations are the equivalent of a fred flintstone car
func pickup_percentage_text_formatter(pick_up_time, inventory_delay):
	var percent = ((pick_up_time - inventory_delay) / pick_up_time)
	if (percent > 0):
		percent = floor(percent * 100)
		if percent < 10:
			return "|"
		if percent < 20:
			return "||"
		if percent < 30:
			return "|||"
		if percent < 40:
			return "||||"
		if percent < 50:
			return "|||||"
		if percent < 60:
			return "||||||"
		if percent < 70:
			return "|||||||"
		if percent < 80:
			return "||||||||"
		if percent < 90:
			return "|||||||||"
		else:
			return "||||||||||"
	else:
		return "||||||||||"
	
	
	
	
	
	