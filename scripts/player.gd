extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animated_smoke_l = $AnimatedSprite2D/AnimatedSmokeL
@onready var animated_smoke_r = $AnimatedSprite2D/AnimatedSmokeR

@export_group("Locomotion")

@export var run_speed_damping = 1.25
@export var speed = 150
@export var jump_velocity = -350

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
@onready var audio_jump = $AudioJump
@onready var audioslide = $Audioslide
@onready var coyote_timer = $CoyoteTimer

func _physics_process(delta):
	
	var was_on_floor = is_on_floor()
	
	if Input.is_action_pressed("walk"):
		speed = 100
	else:
		speed = 150
	
	if not is_on_floor():
		velocity.y += gravity * delta
		animated_sprite.play("jump")
		
	if Input.is_action_just_pressed("jump") and (is_on_floor() or not coyote_timer.is_stopped()):
		velocity.y = jump_velocity
		audio_jump.play()
		coyote_timer.stop()
		
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = 0.5
		
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = lerpf(velocity.x, speed * direction, run_speed_damping * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * delta)	
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	
	if Input.is_action_pressed("down"):
		animated_sprite.play("jump")
		velocity.x = move_toward(velocity.x, 0, speed * delta)	
		
	#if Input.is_action_just_released("move_right") and velocity.x > 100:
		#animated_smoke_r.play("smokefxr")
		#
	#if Input.is_action_just_released("move_left") and velocity.x > 100:
		#animated_smoke_l.play("smokefxl")
	
	move_and_slide()
		
	if was_on_floor and not is_on_floor() and not Input.is_action_just_pressed("jump"):
		coyote_timer.start()
		
func _input(event: InputEvent):
	if(event.is_action_pressed("down") and is_on_floor()):
		position.y += 4

#func _on_area_entered(_body):
	#emit_signal("hit")
	#animated_sprite_2d.play("hit")
	






