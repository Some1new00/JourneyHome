extends Area2D
@onready var player: Player = $"../Player"
#@onready var enemy: Enemy = $"res://scenes/Enemy.tscn"
#@onready var tile_map: TileMapLayer = $TileMapLayer
var facing:int = 1
var speed = 75
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _process(delta: float) -> void:
	self.position += transform.x * speed * delta 
	
func firing() -> void:
	if player.facing_right == false:
		self.scale.x = -1
	else:
		self.scale.x = 1
		
func _on_area_entered(area: Area2D) -> void:
	if area as Enemy:
		area.killedThem()
		speed = 0
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.play("explode")
		await get_tree().create_timer(5).timeout
		self.queue_free()

func _on_body_entered(body: Node2D) -> void:
	$AnimatedSprite2D.stop()
	speed = 0
	$AnimatedSprite2D.play("explode")
	await get_tree().create_timer(1).timeout
	self.queue_free()
	
	

	
