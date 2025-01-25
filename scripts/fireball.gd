extends Area2D
@onready var player: Player = $"../Player"
#@onready var enemy: Enemy = $"res://scenes/Enemy.tscn"
#preload("res://scenes/Enemy.tscn")
#@onready var tile_map: TileMapLayer = $TileMapLayer
var facing:int = 1
var speed = 111
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")
	body_entered.connect(_on_body_entered)
func _process(delta: float) -> void:
	self.position += transform.x * speed * delta 
	await get_tree().create_timer(2).timeout
	if self.scale.x <0:
		$AnimationPlayer.play("RunoutLeft")
	else:
		$AnimationPlayer.play("Runout")
	await get_tree().create_timer(.4).timeout
	self.queue_free()
		
func firing() -> void:
	if player.facing_right == false:
		self.scale.x = -1
	else:
		self.scale.x = 1
		

func _on_body_entered(body) -> void:
	if body is Enemy:
		$Enemy.killedThem()
		speed = 0
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.play("explode")
		await get_tree().create_timer(1).timeout
		self.queue_free()
	else:
		$AnimatedSprite2D.stop()
		speed = 0
		$AnimatedSprite2D.play("explode")
		await get_tree().create_timer(1).timeout
		self.queue_free()

	
