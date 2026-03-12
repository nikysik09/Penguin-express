extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

@export var speed: float = 200.0

func _physics_process(_delta: float) -> void:
	var direction = Vector2.ZERO
	
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("back") - Input.get_action_strength("front")
	
	if direction != Vector2.ZERO:
		velocity = direction.normalized() * speed
		
		# Пріоритет горизонтального руху (ліво/право)
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				sprite.play("right")
			else:
				sprite.play("left")
			# Вимикаємо flip_h, бо у тебе є окремі анімації left/right
			sprite.flip_h = false 
			
		# Пріоритет вертикального руху (вперед/назад)
		else:
			if direction.y > 0:
				sprite.play("back")  # Рух вниз (S)
			else:
				sprite.play("front") # Рух вгору (W)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)
		# Якщо у тебе немає анімації "idle", залиш "front" або створи "idle"
		if sprite.sprite_frames.has_animation("idle"):
			sprite.play("idle")
		else:
			sprite.stop() # Або sprite.play("front") щоб він просто стояв

	move_and_slide()
