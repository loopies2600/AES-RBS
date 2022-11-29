extends Panel

var yOffset := 0

func _ready():
	$Exit.set_as_toplevel(true)
	
	for i in range(Global.MONSTER_COUNT):
		get_child(i).setup(i)
	
	var _unused = $Scroller.connect("pressed", self, "_scrDown")
	
func _scrDown():
	yOffset = -550 if yOffset == 0 else 0
	$Scroller.rect_scale.y = -1 if yOffset == 0 else 1
	
func _process(delta):
	get_tree().get_current_scene().monMenuOpen = true
	
	$Scroller.rect_position.y = lerp($Scroller.rect_position.y, 584 if yOffset == 0 else 1064, 16 * delta)
	rect_position.y = lerp(rect_position.y, yOffset, 16 * delta)
