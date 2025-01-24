extends Area2D
@onready var player: Player = $"../Player"
#@onready var enemy: Enemy = $"res://scenes/Enemy.tscn"
#@onready var tile_map: TileMapLayer = $TileMapLayer
var facing:int = 1
var speed = 75
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#add animation for explosion
	$AnimatedSprite2D.play("default")

func _process(delta: float) -> void:
	self.position += transform.x * speed * delta 
	#add *facing back to line 14 for using line 16
#func firing(dir) -> void:
	#facing = dir
	#if dir < 0:
		#self.scale.x =1
	#elif dir > 0:
		#self.scale.x =-1
	
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
	
	

	
