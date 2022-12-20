extends Button

func _pressed():
	if get_tree().get_current_scene().monMenuOpen: return
	
	var player = get_tree().get_current_scene().playerMon
	var opponent = get_tree().get_current_scene().opponentMon
	
	get_tree().get_current_scene().monMenuOpen = true
	player.guarding = true
	
	yield(get_tree().create_timer(Global.TURN_DELAY / 2), "timeout")
	
	Global.attack(opponent, player, player.resource.Def)
	
	yield(get_tree().create_timer(Global.TURN_DELAY / 2), "timeout")
	
	get_tree().get_current_scene().monMenuOpen = false
	player.guarding = false
	
