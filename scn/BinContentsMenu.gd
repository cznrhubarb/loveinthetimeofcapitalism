extends Sprite

var old_sprites = []

func fill_with_icon(icon_type):
	print("Filling with " + icon_type)
	for spr in old_sprites:
		remove_child(spr)
	
	old_sprites = []
	
	for i in range(0, 40):
		var icon = Sprite.new()
		icon.texture = load("res://img/items/" + icon_type + ".png")
		icon.position = Vector2(rand_range(-150, 150), rand_range(-175, 100))
		icon.rotation = rand_range(0, 3.14159*2)
		icon.scale = Vector2(0.35, 0.35)
		add_child(icon)
		old_sprites.push_back(icon)