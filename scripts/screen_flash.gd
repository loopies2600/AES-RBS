extends ColorRect

func _process(delta):
	modulate.a = lerp(modulate.a, 0.0, 32.0 * delta)
