extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
func _ready() -> void:

	
	if Global.player_position != Vector2.ZERO:
		global_position = Global.player_position
		print("Пінгвін повернувся на позицію: ", global_position)
		
@export var MIN_SPEED: float = 200.0
@export var TOP_SPEED: float = 600.0 
@export var ACCEL: float = 2.0
@export var FRICTION: float = 1.0
@export var TIME_FOR_MAX_SPEED: float = 100.0

var current_max_speed = 100.0
var is_falling = false
var move_timer = 0.0

func _physics_process(delta: float) -> void:
	if is_falling:
		velocity = velocity.lerp(Vector2.ZERO, FRICTION * delta)
		move_and_slide()
		return

	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("back") - Input.get_action_strength("front")

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		move_timer += delta
		
		var progress = clamp(move_timer / TIME_FOR_MAX_SPEED, 0.0, 1.0)
		current_max_speed = lerp(MIN_SPEED, TOP_SPEED, progress)
		
		velocity = velocity.lerp(direction * current_max_speed, ACCEL * delta)
		
		_play_direction_animation(direction)
		
		if move_timer >= TIME_FOR_MAX_SPEED:
			trigger_fall()
			
	else:
		move_timer = 0.0
		current_max_speed = MIN_SPEED
		velocity = velocity.lerp(Vector2.ZERO, FRICTION * delta)
		
		if velocity.length() > 20:
			_play_direction_animation(velocity.normalized())
		else:
			velocity = Vector2.ZERO
			if sprite.animation != "front":
				sprite.play("front")
			sprite.stop()

	move_and_slide()

func _play_direction_animation(dir: Vector2):
	if abs(dir.x) > abs(dir.y):
		sprite.play("right" if dir.x > 0 else "left")
	else:
		if dir.y < 0:
			sprite.play("back")
		else:
			sprite.play("front")

func trigger_fall() -> void:
	if is_falling: return
	is_falling = true
	move_timer = 0.0
	current_max_speed = MIN_SPEED
	
	var fall_anim = "front" 
	if abs(velocity.x) > abs(velocity.y):
		fall_anim = "fall_right" if velocity.x > 0 else "fall_left"
	else:
		fall_anim = "fall_front" if velocity.y > 0 else "fall_back"
	
	if sprite.sprite_frames.has_animation(fall_anim):
		sprite.play(fall_anim)
	
	await get_tree().create_timer(1.5).timeout 
	is_falling = false
