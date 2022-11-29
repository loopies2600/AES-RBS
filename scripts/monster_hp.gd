extends Node2D

const HEART := preload("res://monster/health_numbers/heart.tres")
const NUMTEX := [preload("res://monster/health_numbers/0.tres"),
				preload("res://monster/health_numbers/1.tres"),
				preload("res://monster/health_numbers/2.tres"),
				preload("res://monster/health_numbers/3.tres"),
				preload("res://monster/health_numbers/4.tres"),
				preload("res://monster/health_numbers/5.tres"),
				preload("res://monster/health_numbers/6.tres"),
				preload("res://monster/health_numbers/7.tres"),
				preload("res://monster/health_numbers/8.tres"),
				preload("res://monster/health_numbers/9.tres")]
	
var tgtMon : btl_monster

func _ready():
	position = tgtMon.position
	
func _process(_delta):
	update()
	
func _draw():
	var healthString := str(tgtMon.hp)
	
	draw_texture(HEART, Vector2(-72, -150))
	
	for i in range(healthString.length()):
		draw_texture(NUMTEX[int(healthString[i])], Vector2(64 * i, -150))
