class_name Enemy extends CharacterBody2D
var speed = 175
var direction = 1
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var player = get_tree().get_first_node_in_group("Player")

@onready var ENEMY = preload("res://scenes/Enemy.tscn")

var deadnpcwalking = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if ray_cast_right.is_colliding():
		var raycastright = ray_cast_right.get_collider()
	
		direction = -1
		animated_sprite.flip_h = false
		
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = true
	velocity.y = get_gravity().y
	velocity.x = direction*speed
	#self.position.x = direction * speed * delta
	if deadnpcwalking == false:
		$AnimatedSprite2D.play("Run")
	move_and_slide()

		
func killedThem():
	if deadnpcwalking == false:
		#sfx play dead noise
		
		speed = 0
		deadnpcwalking = true
		#had to use set deferred to disable because it was trying to disable it while it was queuefreeing
		$AnimationPlayer.play("Death")
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.play("Death")
		await get_tree().create_timer(.8).timeout
		#plus one to the score
		queue_free()
		
	else:
		return



func _on_enemy_hittable_body_entered(body: Node2D) -> void:

	if body.name=="Player":
		player.handle_danger()
