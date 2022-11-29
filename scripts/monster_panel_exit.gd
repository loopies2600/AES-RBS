extends TextureButton

func _pressed():
	get_tree().get_current_scene().monMenuOpen = false
	get_parent().queue_free()
