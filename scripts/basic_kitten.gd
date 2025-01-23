class_name Kitten extends Area2D
const POWERS = preload("res://scenes/PowerHotbarIcon.tscn")
var can_doublejump = false

@export var cat_icon : Texture2D
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var player: CharacterBody2D = $"../../Player"
enum catColorFlags {WHITE, BLACK, RED}
@export var catColor: catColorFlags


func _ready() -> void:
	$Sprite2D.play("Idle")

func _physics_process(delta: float) -> void:
	pass
func give_reward():
	print("cat")

func _on_body_entered(body: Node2D) -> void:
	$AnimationPlayer.play("pickup")
	await get_tree().create_timer(1).timeout
	visible = false
	queue_free()
	print("OK")
	Globals.KittenPickup.emit(self)
	give_reward()
