class_name Player
extends CharacterBody2D
@onready var stage_start: Node2D = $"../StageStart"

@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D
var can_control : bool = true
const SPEED = 350
var player_death = 0
const JUMP_VELOCITY = -440.0
var can_doublejump = false  
var possible_todoublejump = false
var is_attacking = false
var possibletostartFireball = false
@onready var attack: AnimatedSprite2D = $attack
@onready var collision_shape: CollisionShape2D = $attack/Hurtbox/CollisionShape2D
@onready var hurtbox: Area2D = $attack/Hurtbox
@onready var enemy: Enemy = $"../Enemy"
@onready var marker_2d: Marker2D = $attack/Hurtbox/CollisionShape2D/Marker2D

@onready var fireball = preload("res://scenes/fireball.tscn")

#func _ready() -> void:
	#Globals.KittenPickup.connect(CheckPickup)
	
#func CheckPickup(KittenData) -> void:
	#match KittenData.catColor:
		#catColor.WHITE:
			
func startFireball() -> void:
	if possibletostartFireball == true:
		var fire = fireball.instantiate()
		fire.global_position = marker_2d.global_position
		#fire.firing(velocity.x)
		owner.add_child(fire)
		
		await get_tree().create_timer(1).timeout
		startFireball()
		
func startAttack() -> void:
	$attack.visible = true
	$attack.play("attack")
	is_attacking = true
	
func _on_hurtbox_area_entered(area: Area2D) -> void:
	if enemy and is_attacking:
		enemy.killedThem()
		
func handle_danger() -> void:
	#visible = false
	print("Player Died!")	
	can_control = false
	#death_sfx.play()
	player_death += 1
	if player_death >= 4:
	#	background_music.stop()
	#	game_over_sfx.play()
		$AnimatedSprite2D.play("Death")
		var tween = get_tree().create_tween()
		tween.tween_property(Engine,"time_scale",0.01,.4)
		await tween.tween_callback(game_over)
				
	elif player_death < 4:
		print(player_death)
		$AnimatedSprite2D.play("Damaged")
		await get_tree().create_timer(1).timeout
		reset_play()
	
func reset_play():
	global_position = stage_start.global_position
	visible = true
	can_control = true
	
func game_over():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	Engine.time_scale = 1
	
func turn():
	if velocity.x < 0:
		attack.scale.x = -.5
		player_sprite.flip_h = true
	
	if velocity.x > 0:
		attack.scale.x = .5
		player_sprite.flip_h = false
	

func _physics_process(delta) -> void:
	velocity.x = move_toward(velocity.x, 0, SPEED)
	if not can_control: return
	velocity += get_gravity() * delta
	#on the ground and have upgrade
	
	if Input.is_action_just_pressed("Jump") and is_on_floor() and possible_todoublejump:
		can_doublejump = true
		velocity.y = JUMP_VELOCITY
	
		
	#off the ground with the upgrade
	if Input.is_action_just_pressed("Jump") and !is_on_floor() and can_doublejump:
		can_doublejump = false  
		$AnimatedSprite2D.play("Double")
		velocity.y = JUMP_VELOCITY * 1.2
		
	#on the ground without the upgrade
	elif Input.is_action_just_pressed("Jump") and is_on_floor():
		#jump_sfx.play()  

		velocity.y = JUMP_VELOCITY
	
	var direction :float= Input.get_axis("Left", "Right")
	
	if direction:
	
		velocity.x = direction * SPEED
		if is_on_floor():
			$AnimatedSprite2D.play("Run")
		
	elif not is_on_floor() and velocity.y > 0:
		
		$AnimatedSprite2D.play("Fall")
	elif !is_on_floor() and velocity.y:
		$AnimatedSprite2D.play("Jump")
	elif is_on_floor():
		$AnimatedSprite2D.play("Idle")
		
	turn()

	move_and_slide()
	
