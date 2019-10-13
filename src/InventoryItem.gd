extends Sprite

onready var tween = get_node("Tween")

var type
var desired_position

func init(item):
	texture = load("res://img/items/" + item + ".png")
	type = item
	#scale = Vector2(0.5, 0.5)

func set_desired_position(pos):
	desired_position = pos
	tween.interpolate_property(self, "position", position, pos, 0.35, Tween.TRANS_QUAD, Tween.EASE_IN)
	tween.start()