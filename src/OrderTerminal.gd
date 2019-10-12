extends Sprite

onready var tween = get_tree().get_root().find_node("HUDTween", true, false)
onready var menu = get_tree().get_root().find_node("Slidedown Menu", true, false)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	print("enter")
	
	if body == get_node("StaticBody2D"):
		return
	tween.interpolate_property(menu, "position", Vector2(530, -400), Vector2(530, 200), .5, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()

func _on_Area2D_body_exited(body):
	print("exit")
	tween.interpolate_property(menu, "position", Vector2(530, 200), Vector2(530, -400), .5, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()
