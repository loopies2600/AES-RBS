extends Sprite
class_name btl_monster

const MONSTER_MENU := preload("res://scripts/monster_panel.tscn")

onready var shield = $Shield
onready var cry := $Cry

var res : Monster
export (int) var id = 0 setget _setMonId

var hp := 0
var atkAdd := 0
var defAdd := 0
var spdAdd := 0

var guarding := false
var ownedByPlayer := false
var dead := false

func _init():
	_setMonId(id)
	
func _setMonId(nid):
	if nid > Global.MONSTER_COUNT - 1 || nid < 0: nid = 0
	
	id = nid
	
	res = Global.monResource[id]
	
	dead = false
	hp = res.maxHp
	texture = res.picture
	offset = res.picOffset
	
func _ready():
	cry()
	
func cry():
	cry.stream = load("res://streams/cries/%s.mp3" % id)
	cry.play()
	
	yield(cry, "finished")
	Global.playMusic()
	
func _process(_delta):
	if guarding: shield.visible = !shield.visible
	else: shield.visible = false

func kill():
	dead = true
	yield(get_tree().create_timer(Global.TURN_DELAY / 2), "timeout")
	
	if ownedByPlayer:
		Global.monAmount[id] -= 1
		get_tree().get_current_scene().monMenuOpen = true
		var monMenu = MONSTER_MENU.instance()
		
		get_tree().get_root().add_child(monMenu)
		monMenu.get_node("Exit").queue_free()
	else:
		Global.monAmount[id] += 1
		Global.playerMonHpMemory = get_tree().get_current_scene().playerMon.hp
		get_tree().reload_current_scene()
