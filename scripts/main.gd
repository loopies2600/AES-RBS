extends Node

onready var monVP := $CharacterViewport
onready var buttons := $Buttons

const BTLMON := preload("res://scripts/btl_monster.tscn")

var monMenuOpen := false

var playerMon
var opponentMon

func _ready():
	randomize()
	
	# Player
	playerMon = BTLMON.instance()
	
	playerMon.id = Global.playerMonIdMemory
	playerMon.hp = Global.playerMonHpMemory
	playerMon.position = Vector2(256, 320)
	playerMon.ownedByPlayer = true
	
	monVP.add_child(playerMon)
	
	# Opponent
	opponentMon = BTLMON.instance()
	
	opponentMon.id = randi() % Global.MONSTER_COUNT
	opponentMon.position = Vector2(768, 320)
	opponentMon.flip_h = true
	
	monVP.add_child(opponentMon)
	
	# Their HP huds
	var newHP = load("res://scripts/monster_hp.tscn").instance()
	newHP.tgtMon = playerMon
	
	add_child(newHP)
	
	newHP = load("res://scripts/monster_hp.tscn").instance()
	newHP.tgtMon = opponentMon
	
	add_child(newHP)
	
func _process(delta):
	buttons.rect_position.y = lerp(buttons.rect_position.y, 150 if monMenuOpen else 0, 16 * delta)
