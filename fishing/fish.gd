extends CharacterBody2D

@export var aquaContainer : Control
@onready var fish_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED := 500.0
var targetPosition: Vector2
var borderDistance := 10

func _ready() -> void:
	await get_tree().physics_frame
	_set_new_target_position()
	
func _set_new_target_position() -> void:
	if not aquaContainer: return
	var boxSize := aquaContainer.get_global_rect()
	
	var min_x = int(boxSize.position.x + borderDistance)
	var max_x = int(boxSize.position.x + boxSize.size.x - borderDistance)
	var min_y = int(boxSize.position.y + borderDistance)
	var max_y = int(boxSize.position.y + boxSize.size.y - borderDistance)
	
	targetPosition = Vector2(randi_range(min_x, max_x), randi_range(min_y, max_y))

func _physics_process(_delta: float) -> void:
	var distance = global_position.distance_to(targetPosition)
	
	if distance > 5:
		var direction := (targetPosition - global_position).normalized()
		velocity = direction * SPEED
		fish_sprite.flip_h = velocity.x < 0
	else:
		velocity = Vector2.ZERO
		_on_target()
		
	if velocity.length() > 0:
		fish_sprite.play("move")
	else:
		fish_sprite.stop()
		
	move_and_slide()

func _on_target() -> void:
	set_physics_process(false)
	await get_tree().create_timer(1.5).timeout
	_set_new_target_position()
	set_physics_process(true)
