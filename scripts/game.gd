extends Node2D
@onready var fireball = preload("res://scenes/fireball.tscn")
@onready var player: Player = $Player
const ENEMY = preload("res://scenes/Enemy.tscn")
var possibletostartSpawning = false

func _ready() -> void:
	Engine.time_scale = 1
	await get_tree().create_timer(2)
	startSpawning()
	
func startSpawning() -> void:
	var clone = ENEMY.instantiate()
	clone.global_position = %EnemySpawner.global_position
	add_child(clone)
	await get_tree().create_timer(1).timeout
	startSpawning()

func onBlackKitten():
	if player.is_attacking:
		$AnimationPlayer.play("AttackInfoBox")
		
func onRedKitten():
	if player.possibletostartFireball:
		$AnimationPlayer.play("FireballInfo")
		
func onBasicKitten():
	if player.is_on_floor():
		$AnimationPlayer.play("JumpInfoBox")
		
func _process(_delta: float) -> void:
	pass
