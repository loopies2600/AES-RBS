extends Node

const MONSTER_COUNT := 9
const TURN_DELAY := 1.0

var monResource := []
var monAmount := []
var playerMonIdMemory := 0
var playerMonHpMemory := 10

onready var bgm := AudioStreamPlayer.new()

# Set up monster resources for later use!!!
func _init():
	for i in range(MONSTER_COUNT):
		monResource.append(load("res://monster/" + str(i) + ".tres"))
		monAmount.append(1)
	
func _ready():
	add_child(bgm)
	bgm.stop()
	
func playMusic():
	if bgm.playing: return
	
	bgm.stream = load("res://streams/battle.mp3")
	bgm.play()
	
func attack(attacker : btl_monster, target : btl_monster, def := 0):
	if attacker.dead: return
	
	var particle = load("res://scripts/attack_anim.tscn").instance()
	
	add_child(particle)
	particle.position = target.position
	
	var hpCalc : int = target.hp - attacker.res.atk - def
	
	if hpCalc <= 0:
		target.hp = 0
		target.kill()
		return
	
	target.hp -= (attacker.res.atk - def)
