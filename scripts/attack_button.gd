extends Button

func _pressed():
	if get_tree().get_current_scene().monMenuOpen: return
	
	get_tree().get_current_scene().monMenuOpen = true
	
	var player = get_tree().get_current_scene().playerMon
	var opponent = get_tree().get_current_scene().opponentMon
	
	if player.resource.Spd > opponent.resource.Spd:
		yield(_atkNdelay(player, opponent), "completed")
		yield(_atkNdelay(opponent, player), "completed")
	else:
		yield(_atkNdelay(opponent, player), "completed")
		yield(_atkNdelay(player, opponent), "completed")
		
	get_tree().get_current_scene().monMenuOpen = false
	
func _atkNdelay(attacker, target):
	yield(get_tree().create_timer(Global.TURN_DELAY / 2), "timeout")
	
	Global.attack(attacker, target)
	
	yield(get_tree().create_timer(Global.TURN_DELAY / 2), "timeout")
	
