class_name Enemy extends CharacterBody2D
var speed = 175
var direction = 1
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var player = get_tree().get_first_node_in_group("Player")


var deadnpcwalking = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#startspawning()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = false
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = true
	velocity.x = direction*speed
	#self.position.x = direction * speed * delta
	if deadnpcwalking == false:
		$AnimatedSprite2D.play("Run")
	move_and_slide()

		
func killedThem():
	#sfx play dead noise
	speed = 0
	deadnpcwalking = true
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.play("Death")
	await get_tree().create_timer(.9).timeout
	#plus one to the score
	queue_free()


#func startspawning():
	#var clone = DUPLICATE_USE_INSTANTIATION
	#clone.position.x = randf_range(-200, 200)
	#add_child(clone)


func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area.name)
	if area.name == "Hurtbox": pass
	elif area.name == "PlayerhurtArea":
		player.handle_danger()
	
