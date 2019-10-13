extends Node2D

var speed = 100
var belts = []

# Called when the node enters the scene tree for the first time.
func _ready():
	belts.append(get_node("BeltOne"))
	belts.append(get_node("BeltTwo"))
	belts.append(get_node("BeltThree"))
	belts.append(get_node("BeltFour"))

func _process(delta):
	for belt in belts:
		belt.position.y += speed * delta
		if belt.position.y > 1296:
			belt.position.y -= 1296