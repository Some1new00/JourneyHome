extends Area2D
@onready var player: Player = $"../Player"
#@onready var enemy: Enemy = $"res://scenes/Enemy.tscn"

#@onready var tile_map: TileMapLayer = $TileMapLayer
var facing:int = 1
var speed = 133
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")
	body_entered.connect(enemy_entered)
	
func _process(delta: float) -> void:
	self.position += transform.x * speed * delta 
	await get_tree().create_timer(2).timeout
	if self.scale.x <0:
		$AnimationPlayer.play("RunoutLeft")
	elif self.scale.x >0:
		$AnimationPlayer.play("Runout")
	await get_tree().create_timer(.4).timeout
	self.queue_free()
		
func firing() -> void:
	if player.facing_right == false:
		self.scale.x = -1
	else:
		self.scale.x = 1
		

func enemy_entered(body):
	if body as Enemy:
		var enemy:Enemy = body
		enemy.killedThem()
		speed = 0
		$AnimatedSprite2D.stop()
		$CollisionShape2D.set_deferred("disabled",true)
		$AnimatedSprite2D.play("explode")
		await get_tree().create_timer(1).timeout
		self.queue_free()
	else:
		$AnimatedSprite2D.stop()
		speed = 0
		$AnimatedSprite2D.play("explode")
		$CollisionShape2D.set_deferred("disabled",true)
		await get_tree().create_timer(1).timeout
		self.queue_free()

	





	
