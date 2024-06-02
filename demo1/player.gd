extends CharacterBody2D

const RUN_SPEED := 200.0
const JUMP_VELOCITY := -300.0

var gravirty := ProjectSettings.get("physics/2d/default_gravity") as float

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move_left","move_right")
	velocity.x = direction * RUN_SPEED
	print(velocity.x)
	velocity.y += gravirty * delta
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
	
	if is_on_floor():
		if is_zero_approx(direction):
			animation_player.play("idle")
		else:
			animation_player.play("running")
	else:
		animation_player.play("jump")
	
	if not is_zero_approx(direction):
		sprite_2d.flip_h = direction < 0
		print(sprite_2d.flip_h)
		
	move_and_slide()
