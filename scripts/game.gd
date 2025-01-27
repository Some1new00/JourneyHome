extends Node2D
@onready var fireball = preload("res://scenes/fireball.tscn")
@onready var game: Node2D = $"."

const ENEMY = preload("res://scenes/Enemy.tscn")
# Called when the node enters the scene tree for the first time.
var possibletostartSpawning = false
func _ready() -> void:
	await get_tree().create_timer(2)
	startSpawning()

func startSpawning() -> void:
	var clone = ENEMY.instantiate()
	clone.global_position = %EnemySpawner.global_position
	add_child(clone)
	await get_tree().create_timer(5).timeout
	startSpawning()
	print("spawning!")


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
