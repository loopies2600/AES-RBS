extends Button

var monId := 0

func setup(id := 0):
	monId = id
	get_node("Name").text = Global.monResource[id].Name
	icon = Global.monResource[id].Sprite
	get_node("Amount").text = "x %s" % Global.monAmount[id]
	disabled = Global.monAmount[id] == 0
	
func _pressed():
	get_tree().get_current_scene().playerMon.id = monId
	Global.playerMonIdMemory = monId
	get_tree().get_current_scene().playerMon.playCry()
	get_tree().get_current_scene().monMenuOpen = false
	get_parent().queue_free()
