extends Button

const MONSTER_MENU := preload("res://scripts/monster_panel.tscn")

func _pressed():
	if get_tree().get_current_scene().monMenuOpen: return
	
	get_tree().get_current_scene().monMenuOpen = true
	var monMenu = MONSTER_MENU.instance()
	
	get_tree().get_root().add_child(monMenu)
