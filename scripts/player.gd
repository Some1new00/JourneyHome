extends CharacterBody2D

@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D
var can_control : bool = true
const SPEED = 500.0
const JUMP_VELOCITY = -400.0
func turn():
	if velocity.x < 0:
		player_sprite.flip_h = true
	if velocity.x > 0:
		player_sprite.flip_h = false

func _physics_process(delta) -> void:
	print (Engine.get_frames_per_second())
	
	if not can_control: return
	velocity += get_gravity() * delta
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		
		velocity.y += JUMP_VELOCITY

	var direction :float= Input.get_axis("Left", "Right")
	if direction:
		$AnimatedSprite2D.play("Run")
		velocity.x = direction * SPEED
	elif velocity.y < 0:
		$AnimatedSprite2D.play("Jump")
	elif not is_on_floor():
		$AnimatedSprite2D.play("Fall")
	else:
		$AnimatedSprite2D.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	turn()

	move_and_slide()
