extends Button

var monId := 0

func setup(id := 0):
	monId = id
	get_node("Name").text = Global.monResource[id].name
	icon = Global.monResource[id].picture
	get_node("Amount").text = "x %s" % Global.monAmount[id]
	disabled = Global.monAmount[id] == 0
	
func _pressed():
	get_tree().get_current_scene().playerMon.id = monId
	Global.playerMonIdMemory = monId
	get_tree().get_current_scene().playerMon.cry()
	get_tree().get_current_scene().monMenuOpen = false
	get_parent().queue_free()
